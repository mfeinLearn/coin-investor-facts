# the execution point in a web based ruby application - config.ru

# 1. load an enviornment
require './config/environment'

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

# In order to send PATCH and DELETE requests, I will need to add a line of code here...
use Rack::MethodOverride
use UsersController
use InvestmentEntriesController

run ApplicationController
