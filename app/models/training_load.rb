# == Schema Information
#
# Table name: training_loads
#
#  id         :integer          not null, primary key
#  player_id  :integer
#  date       :date
#  rating     :integer
#  duration   :integer
#  category   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_training_loads_on_player_id  (player_id)
#

# Note the duration is in minutes.
class TrainingLoad < ActiveRecord::Base
  CATEGORIES = ['Team Training', 'Game', 'Lifting', 'Plyometric', 'Recovery', 'Other']

  belongs_to :player
  scope :order_by_date, -> { order('date ASC') }
  validates :category,
    inclusion: { in: CATEGORIES },
    presence: true
  validates :date, presence: true
  validates :duration,
    inclusion: { in: 0..300 },
    numericality: { only_integer: true }
  validates :player, presence: true
  validates :rating,
    inclusion: { in: 0..10 },
    numericality: { only_integer: true },
    presence: true

  def self.three_days_from date
    where date:(date-1)..(date -3)
  end
  
  def self.to_h
    all.inject({}) {|results,load| results[load.date]= load.value; results}
  end   

  def value
    rating * duration if rating && duration
  end
end
