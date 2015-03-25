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

  def last_7_training_loads
    training_loads.order_by_date.last(7)
  end
end
