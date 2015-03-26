module TrainingLoads
  def self.recover_time load_for_starting_date, loads_three_days_prior
    _recover_time(load_for_starting_date, loads_three_days_prior)
  end
  private
  def self._recover_time(today, loads_three_days_prior, days_to_recover=0)
    residuals =  loads_three_days_prior.each_with_index.map do |load,index|
      (rfactor(load,index+1) * load).to_i
    end
    perceived_load_today = residuals.sum + today
    return days_to_recover if perceived_load_today == 0
    #load not zero need another day
    to_recover = days_to_recover + 1
    #loads for the following day
    days_prior = [perceived_load_today] + loads_three_days_prior[0..1] 
    #load for following days
    following_day_load = 0 #resting to recover
    _recover_time(following_day_load, days_prior, to_recover)
  end

  #residual factor table
  RFACTOR = {
    "750" => [0.40, 0.20, 0.10],
    "250"=> [0.30, 0.15, 0.05],
    "0" => [0.20, 0.10 , 0.00]
  }
  def self.rfactor load, days_prior 
    index = days_prior - 1
    if load >= 750
      return RFACTOR["750"][index]
    elsif load >= 250
      return RFACTOR["250"][index]
    elsif load >= 0
      return RFACTOR["0"][index]
    end       
  end    
end
