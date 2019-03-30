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

  # When this application recieves a ***http request*** it does the following steps:
  # 1. The application examines on the request
  # 2a. The application examines the http method which is now a - get
  # 2b. The application also examines the url which is now a - root route
  # 3. The application then matches that controller action that has that http verb method and url(route)
  # 4. The application examines the code in that controller action
  # 5. Figures out what response to send back
  get '/' do
    erb :welcome
  end

  get '/categories' do
      erb :"application/index"
  end

  helpers do

    def logged_in?
      # true if user is logged in, otherwise false
      # !! - if the object is not nil or false it will be true
      #   if the object is nil or false it will return false
      !!current_user
    end

    def current_user
      # if their is a user that is logged in this means
      # the user.id is set to the session value of the
      # key of the user_id that we set when we login or signup
      #
      # if their is a user logged in or signup
      # find that user and return it and set it to @current_user
      #binding.pry
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end

    def redirect_if_not_logged_in
      if !logged_in?
        flash[:errors] = "You must be logged in to view the page you tried to view."
        redirect '/'
      end
    end

    def authorized_to_edit?(coins)
      # InvestmentEntry class has a method called
      # user which

      # Thanks to activerecord we get access to the user method from the
      # attribute accessor of belongs_to from the investment_entry model
      # which gives us access to a user
      coins.users.last == current_user
    end

  end

end
