ENV['SINATRA_ENV'] ||= "development" # set the environment
                                     # HASH with the key of
                                     # 'SINATRA_ENV to development

require 'bundler/setup'  # requiring gems
Bundler.require(:default, ENV['SINATRA_ENV'])

# ActiveRecord::Base.establish_connection(
#   :adapter => "sqlite3",
#   :database => "db/#{ENV['SINATRA_ENV']}.sqlite"
# )# get my database connection ready

ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "db/#{ENV['SINATRA_ENV']}.sqlite"
)

require './app/controllers/application_controller'
require_all 'app' # require all of the files in app
