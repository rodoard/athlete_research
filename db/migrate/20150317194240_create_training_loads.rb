class CreateTrainingLoads < ActiveRecord::Migration
  def change
    create_table :training_loads do |t|
      t.references :player, index: true
      t.date :date
      t.integer :rating
      t.integer :duration
      t.string :category

      t.timestamps null: false
    end
    add_foreign_key :training_loads, :players
  end
end
