class StartupsController < ApplicationController

  get '/startups' do
    if logged_in?
      @startups = Startup.all
      erb :'/startups/index'
    else
      redirect "/login"
    end
  end

end
