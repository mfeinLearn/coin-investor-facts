class InvestmentEntriesController < ApplicationController


  get '/investment_entries' do
    if logged_in?
      @investment_entries = InvestmentEntry.all
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
    if params[:coin_name] != "" && params[:community] != "" && params[:code] != "" && params[:whitepaper] != "" && params[:user_id] != "" && params[:date] != "" && params[:team] != ""
      datetime = DateTime.now
      @investment_entry = InvestmentEntry.create(coin_name: params[:coin_name], community: params[:community], code: params[:code], whitepaper: params[:whitepaper], user_id: current_user.id, date: datetime)
      @team = Team.create(name: params[:name],investment_entry_id: params[:investment_entry_id] )
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
    #binding.pry
    if current_user.id == @investment_entry.user_id && params[:coin_name] != "" && params[:community] != "" && params[:code] != "" && params[:whitepaper] != ""  && params[:team] != ""
      @investment_entry.update(:coin_name => params[:coin_name], :community => params[:community], :code => params[:code], :whitepaper => params[:whitepaper])#, user_id: current_user.id, date: datetime)
      @team.update(name: params[:name])
      redirect "/investment_entries/#{@investment_entry.id}"
    else
      redirect "/investment_entries/#{@investment_entry.id}/edit"
    end
  end

  delete '/investment_entries/:id' do
    set_investment_entry
    if logged_in? && current_user.id == @investment_entry.user_id
      @investment_entry.destroy
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
