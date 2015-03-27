Rails.application.routes.draw do
  root 'dashboard#index'
  get '/players/:player_id/training_load' => 'player#training_load', as: 'player_training_load'
end
