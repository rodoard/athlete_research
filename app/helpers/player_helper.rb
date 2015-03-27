module PlayerHelper
  def training_load_for date, loads
    loads.select do |load|
      load.date == date  
    end.to_a.sum(&:value)  
  end   
  def recover_time_for date, starting_date_training_load, training_loads
    past_three_days_training_loads = three_days_prior_training_loads_from date, training_loads
    Training.recover_time(date, starting_date_training_load,  past_three_days_training_loads).days_to_recover
  end
  private
  def three_days_prior_training_loads_from date, training_loads
    range = (date-1).downto(date-3).map {|date|date}
    result = training_loads_in_range range, training_loads
    result = result.inject({}) do |collection,load|
      collection[load.date] ||=0
      collection[load.date] += load.value
      collection
    end   
    defaults = {}
    range.each do |day|
      defaults[day]=0
    end   
    defaults.merge(result).values
  end
  def training_loads_in_range range, training_loads
    training_loads.select {|load|range.include? load.date}
  end  
end
