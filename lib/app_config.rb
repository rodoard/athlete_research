module AppConfig
  def self.app
    APP_CONFIG
  end 
  def self.training_rfactor_strategy
    app.rfactor.strategy
  end  
end   