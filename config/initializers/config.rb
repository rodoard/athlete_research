require "#{Rails.root}/lib/app_config"
APP_CONFIG = RecursiveOpenStruct.new(YAML.load(File.read(Rails.root.join('config','app.yml'))))