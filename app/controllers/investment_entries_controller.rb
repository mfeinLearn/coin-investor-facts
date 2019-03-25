class InvestmentEntriesController < ApplicationController


  get '/investment_entries' do
    if logged_in?
      @investment_entries = InvestmentEntry.all
      @team = Team.all

      erb :'/investment_entries/index'
    else
      redirect "/login"
    end
  end

  get'/investment_entries/new' do
    if logged_in?
      erb :'/investment_entries/new'
    else
      redirect "/login"
    end
    #display a form for creation
  end

  post '/investment_entries' do
    redirect_if_not_logged_in
    if params[:coin_name] != "" && params[:community] != "" && params[:code] != "" && params[:whitepaper] != "" && params[:user_id] != "" && params[:date] != "" #&& params[:team0] != ""
      datetime = DateTime.now
      @investment_entry = InvestmentEntry.create(coin_name: params[:coin_name], community: params[:community], code: params[:code], whitepaper: params[:whitepaper], user_id: current_user.id, date: datetime)
    #  raise params.inspect
      @investment_entry.teams << Team.create(name: params[:team0])
      @investment_entry.teams << Team.create(name: params[:team1])
      @investment_entry.teams << Team.create(name: params[:team2])
      @investment_entry.teams << Team.create(name: params[:team3])
      @investment_entry.save
      #binding.pry
      #raise params.inspect
      flash[:message] = "Investment Entry successfully created." if @investment_entry.id
      redirect "/investment_entries"
    else
      flash[:errors] = "Something went wrong - you must provide content for your entry."
      redirect '/investment_entries/new'
    end
  end


  get '/investment_entries/:id' do
    if logged_in?
      set_investment_entry
      erb :'/investment_entries/show'
   else
     redirect "/login"
   end
  end
  #
  #
  get '/investment_entries/:id/edit' do
      set_investment_entry
      redirect_if_not_logged_in
    if authorized_to_edit?(@investment_entry)
      erb :'/investment_entries/edit'
    else
      redirect "/login"
    end
  end

  patch '/investment_entries/:id' do
    set_investment_entry
    redirect_if_not_logged_in
    #raise params.inspect
    if current_user.id == @investment_entry.user_id && params[:coin_name] != "" && params[:community] != "" && params[:code] != "" && params[:whitepaper] != "" # && params[:team0] != ""
      @investment_entry.update(:coin_name => params[:coin_name], :community => params[:community], :code => params[:code], :whitepaper => params[:whitepaper])#, user_id: current_user.id, date: datetime)
      # @investment_entry.teams << Team.update(name: params[:team0])
      # @investment_entry.teams << Team.update(name: params[:team1])
      # @investment_entry.teams << Team.update(name: params[:team2])
      # @investment_entry.teams << Team.update(name: params[:team3])
      @investment_entry.teams[0].name = params[:team0]
      @investment_entry.teams[1].name = params[:team1]
      @investment_entry.teams[2].name = params[:team2]
      @investment_entry.teams[3].name = params[:team3]

      #binding.pry
      @investment_entry.save
      # if params[:team0] != ""
      #   @team.update(name: params[:team0])
      # end
      # if params[:team1] != ""
      #   @team.update(name: params[:team1])
      # end
      # if params[:team2] != ""
      #   @team.update(name: params[:team2])
      # end
      # if params[:team3] != ""
      #   @team.update(name: params[:team3])
      # end
      redirect "/investment_entries/#{@investment_entry.id}"
    else
      redirect "/investment_entries/#{@investment_entry.id}/edit"
    end
  end

  delete '/investment_entries/:id' do
    set_investment_entry
    if logged_in? && current_user.id == @investment_entry.user_id
      @investment_entry.destroy
      # @team.destroy
      # @team.destroy
      # @team.destroy
      # @team.destroy
      flash[:message] = "Successfully deleted that entry."
      redirect "/investment_entries"
    else
      redirect "/investment_entries"
    end
  end

    private # it is something that we are not
  # going to called outside of this class

  def set_investment_entry
    datetime = DateTime.now
    @investment_entry = InvestmentEntry.find(params[:id])
  end


end
