# == Schema Information
#
# Table name: players
#
#  id         :integer          not null, primary key
#  first_name :string
#  last_name  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Player < ActiveRecord::Base
  has_many :training_loads

  def full_name
    "#{first_name} #{last_name}"
  end

  def recover_time_for date
    training_load_for_start_date = training_load_for date
    three_days_prior_training_loads = three_days_prior_training_loads_from date
    Training.recover_time(date, training_load_for_start_date , three_days_prior_training_loads)
  end 
    
  def last_7_training_loads
    training_loads.order_by_date.last(7)
  end
end
