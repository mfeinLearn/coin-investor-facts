class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect "/investment_entries"
    else
      erb :"users/create_user"
    end
  end

  post '/signup' do
    #binding.pry
    if params[:username] != "" && params[:email] != "" && params[:password] != ""
      # create a new user
      @user = User.new(username: params[:username], email: params[:email], password: params[:password])
      @user.save
      session[:user_id] = @user.id
      redirect to "/investment_entries"

    else
      redirect '/signup'
    end
  end

  get '/login' do
    if logged_in?
      redirect '/investment_entries'
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    #binding.pry
    # authenticate is a method from the has_secure_password
    # more on has_secure_password in the User model
    # this takes in a string which is a pasword
    # and returns a hashed version of the password.
     if @user && @user.authenticate(params[:password])
      #raise params.inspect
      session[:user_id] = @user.id # actually logging the user in
      flash[:message] = "Welcome, #{@user.username}!"
      redirect "/investment_entries"
    else
      flash[:errors] = "Your credentials were invalid. Please sign up or try again."
      # tell the user they entered invalid credentials
      # redirect them to the login page
      redirect "/signup"
    end
  end

  # user SHOW route
  # this routes job is to show the user
  get '/users/:slug' do # this will be the user show route
    # what do I need to do first?
    # raise params.inspect
    @user = User.find_by_slug(params[:slug])
    #  redirect_if_not_logged_in
    erb :'users/show'
  end

  # # user SHOW route
  # # this routes job is to show the user
  # get '/users/:slug/investment_entries' do
  #   if logged_in?
  #     @investment_entries = InvestmentEntry.all.select()
  #     @team = Team.all.select()
  #
  #     erb :'/investment_entries/index'
  #   else
  #     redirect "/login"
  #   end
  #
  #   erb :'users/personal'
  # end

  get '/logout' do
    if logged_in?
      session.clear
      redirect "/login"
    else
      redirect "/"
    end
  end

end
