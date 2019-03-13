require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "my_super_sacrure_coin_invester_app_secret"
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
