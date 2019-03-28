class StartupEntriesController < ApplicationController

  get '/startup_entries' do
    if logged_in?

      @investment_entries = InvestmentEntry.all
      #binding.pry

      erb :'/startup_entries/index'
    else
      redirect "/login"
    end
  end

  get'/startup_entries/new' do
    if logged_in?
      erb :'/startup_entries/new'
    else
      redirect "/login"
    end
    #display a form for creation
  end

  post '/startup_entries' do
    redirect_if_not_logged_in
    if params[:coin_name] != "" && params[:community] != "" && params[:code] != "" && params[:whitepaper] != "" && params[:user_id] != "" && params[:date] != "" #&& params[:team0] != ""
      datetime = DateTime.now
      #raise params.inspect
      #
      # params =>  {"coin_name"=>"appleCoin",
      #             "community"=>"appleCommunity",
      #             "code"=>"appleCode",
      #             "whitepaper"=>"github.com/appleCoin/appleWhitepaper",
      #             "team0"=>"Mr. Apple",
      #             "team1"=>"Miss. Apple",
      #             "team2"=>"",
      #             "team3"=>"",
      #             "submit"=>"Create Investment Entry"}
      #
      # to use params to create a new resource(investment_entry & Team)
      # - the value of the name attribute in the new.erb view
      #  needs to be used as the key for the params hash to get access
      # to the value which is what the user typed into the form.
      @investment_entry = InvestmentEntry.create(coin_name: params[:coin_name], community: params[:community], code: params[:code], whitepaper: params[:whitepaper], user_id: current_user.id, date: datetime)
      # raise params.inspect
      #1. Thanks to activerecord we get access to the collection of
      #     teams from the investment_entry object that has many teams.
      #2. That puts each Team into the teams array.

      @investment_entry.teams << Team.create(name: params[:team0])
      @investment_entry.teams << Team.create(name: params[:team1])
      @investment_entry.teams << Team.create(name: params[:team2])
      @investment_entry.teams << Team.create(name: params[:team3])
      # 3. Saves the investment_entry object which saves the investment_entry's children
      # which is the Team objects
      @investment_entry.save
      #binding.pry
      #raise params.inspect
      #
      flash[:message] = "Investment Entry successfully created." if @investment_entry.id
      redirect "/startup_entries"
    else
      flash[:errors] = "Something went wrong - you must provide content for your entry."
      redirect '/startup_entries/new'
    end
  end


  get '/startup_entries/:id' do
    if logged_in?
      set_investment_entry
      erb :'/startup_entries/show'
   else
     redirect "/login"
   end
  end
  #
  #
  get '/startup_entries/:id/edit' do
      set_investment_entry
      redirect_if_not_logged_in
    if authorized_to_edit?(@investment_entry)
      erb :'/startup_entries/edit'
    else
      redirect "/login"
    end
  end

  patch '/startup_entries/:id' do
    set_investment_entry
    redirect_if_not_logged_in
    #raise params.inspect
    if current_user.id == @investment_entry.user_id && params[:coin_name] != "" && params[:community] != "" && params[:code] != "" && params[:whitepaper] != "" # && params[:team0] != ""
      @investment_entry.update(:coin_name => params[:coin_name], :community => params[:community], :code => params[:code], :whitepaper => params[:whitepaper])#, user_id: current_user.id, date: datetime)
      #update -It job is to:
      # an Active Record object has been retrieved,
      # its attributes can be modified and it can be saved to the database
      # with update key value pairs has to be used to update an object's attribute
      @investment_entry.teams[0].update(:name => params[:team0])
      @investment_entry.teams[1].update(:name => params[:team1])
      @investment_entry.teams[2].update(:name => params[:team2])
      @investment_entry.teams[3].update(:name => params[:team3])
      #binding.pry
      @investment_entry.save
      redirect "/startup_entries/#{@investment_entry.id}"
    else
      redirect "/startup_entries/#{@investment_entry.id}/edit"
    end
  end

  delete '/startup_entries/:id' do
    set_investment_entry
    if logged_in? && current_user.id == @investment_entry.user_id
      @investment_entry.destroy
      flash[:message] = "Successfully deleted that entry."
      redirect "/startup_entries"
    else
      redirect "/startup_entries"
    end
  end

    private # it is something that we are not
  # going to called outside of this class

  def set_investment_entry
    datetime = DateTime.now
    @investment_entry = InvestmentEntry.find(params[:id])
  end


end
