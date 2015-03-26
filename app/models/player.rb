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

  def training_load_for date
    training_loads.where(date: date).first.value
  end  

  def past_three_days_training_loads_from date
    result = training_loads.three_days_from date
    result = result.inject({}) do |collection,load|
      collection[load.date.to_s]=load.value
      collection
    end   
    loads = {}
    (date-1).downto(date-3).each do |day|
      loads[day.to_s]=0
    end   
    loads.merge(result).values
  end

  def last_7_training_loads
    training_loads.order_by_date.last(7)
  end
end
