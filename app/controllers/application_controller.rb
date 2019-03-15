require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "my_super_sacrure_coin_invester_app_secret"

    # invocked a register method and pass in sinatra flash
    # "flash is just a hash!!"
    # flash only last for one http request
    register Sinatra::Flash
    # I now have access to a hash called flash
    # where I can add key value pairs to a flash message
    # the life cycle of a flash message once I create it
    # is exactly 1 http request

    #NOTE: flash messages must be built at specific points within our controller
    #  that will end in a redirect
    # flash can be used when we create, update, or delete something
    # because create, update, or delete usually ends with a redirect
    # - flash messages only survive one http request. eg. one http request then they are gone
  end

  get '/' do
    erb :welcome
  end

  helpers do

    def logged_in?
      # true if user is logged in, otherwise false
      !!current_user
    end

    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end

    def redirect_if_not_logged_in
      if !logged_in?
        redirect '/'
      end
    end

    def authorized_to_edit?(a_tweet)
      a_tweet.user == current_user
    end

  end

end
