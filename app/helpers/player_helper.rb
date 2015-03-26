module PlayerHelper
  def recover_time(starting_date_training_load, past_three_days_training_loads)
    TrainingLoads.recover_time  starting_date_training_load,  past_three_days_training_loads
  end
end
