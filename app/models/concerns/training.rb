module Training
  mattr_accessor :rfactor_strategy
  #argument hash {date => load_value }
  def self.perceived_loads loads
    loads.inject({}) do |results,(date,load)|
      results[date.to_s] = perceived_loads_for date, load, loads
      results
    end   
  end   
  def self.perceived_loads_with_projection loads
    perceived = loads.inject({}) do |results,(date,load)|
      results[date] = perceived_loads_for date, load, loads
      results
    end 
    perceived_last = perceived.to_a.last
    perceived_last_date = perceived_last.first
    load_for_perceived_last_date = perceived_last.last
    loads_three_days_prior = _loads_three_days_prior perceived_last_date, loads
    perceived.merge recover_time(perceived_last_date, load_for_perceived_last_date, loads_three_days_prior).perceived_loads  
  end   
  def self.recover_time starting_date, load_for_starting_date, loads_three_days_prior
    _recover_time(starting_date, load_for_starting_date, loads_three_days_prior)
  end
  private
  def self._loads_three_days_prior date, loads 
    (date-1).downto(date-3).collect do |date|
      loads.fetch(date,0)
    end 
  end   
  def self.perceived_loads_for date, starting_load, loads
    loads_three_days_prior = _loads_three_days_prior date, loads
    _perceived_load starting_load, loads_three_days_prior
  end  
  def self._perceived_load starting_load, loads_three_days_prior
    residuals = _residual starting_load, loads_three_days_prior  
    residuals.sum + starting_load 
  end 
  def self._residual load, loads_three_days_prior
    loads_three_days_prior.each_with_index.map do |load,index|
      (rfactor(load,index+1) * load).to_i
    end
  end   
  def self._recover_time(starting_date, starting_load, loads_three_days_prior, days_to_recover=0, perceived_loads={})
    perceived_load = _perceived_load starting_load, loads_three_days_prior
    if perceived_load == 0
    perceived = perceived_loads
    perceived = perceived_loads.merge(starting_date => perceived_load) if days_to_recover > 0
    return OpenStruct.new({days_to_recover:days_to_recover, perceived_loads:perceived}) 
    end 
    #load not zero need another day
    to_recover = days_to_recover + 1
    
    #following day
    following_day = starting_date + 1

    perceived = perceived_loads.merge(following_day => perceived_load)

    #loads for the following day
    days_prior = [perceived_load] + loads_three_days_prior[0..1] 
    
    #load for following days
    following_day_load = 0 #resting to recover
    
    _recover_time(following_day, following_day_load, days_prior, to_recover, perceived)
  end

  def self.rfactor load, days_prior 
    index = days_prior - 1
    Training.rfactor_strategy.rfactor load, index
  end 
end

Training.rfactor_strategy = Training::Strategy.send AppConfig.training_rfactor_strategy

