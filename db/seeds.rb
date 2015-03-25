require 'csv'

CSV.foreach("#{Rails.root}/db/seeds/players.csv", headers: true) do |row|
  Player.seed(:id) do |p|
    p.first_name = row['first_name']
    p.last_name = row['last_name']
  end
end

training_load_data = []
CSV.foreach("#{Rails.root}/db/seeds/training_loads.csv", headers: true) do |row|
  training_load_data << row.to_hash
end

TrainingLoad.seed(:id, training_load_data)
