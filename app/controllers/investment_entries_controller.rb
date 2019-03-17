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
    if params[:coin_name] != "" && params[:community] != "" && params[:code] != "" && params[:whitepaper] != "" && params[:user_id] != "" && params[:date] != ""
      datetime = DateTime.now
      @investment_entry = InvestmentEntry.create(coin_name: params[:coin_name], community: params[:community], code: params[:code], whitepaper: params[:whitepaper], user_id: current_user.id, date: datetime)
      flash[:message] = "Investment Entry successfully created." if @investment_entry.id
      redirect "/investment_entries"
    else
      flash[:errors] = "Something went wrong - you must provide content for your entry."
      redirect '/investment_entries/new'
    end
  end


  get '/investment_entries/:id' do
    if logged_in?
      datetime = DateTime.now
      @investment_entry = InvestmentEntry.find(params[:id])
      erb :'/investment_entries/show'
   else
     redirect "/login"
   end
  end
  #
  #
  get '/investment_entries/:id/edit' do
    if logged_in?
      @investment_entry = InvestmentEntry.find(params[:id])
      erb :'/investment_entries/edit'
    else
      redirect "/login"
    end
  end

  patch '/investment_entries/:id' do
    @investment_entry = InvestmentEntry.find(params[:id])
    #binding.pry
    if logged_in? && current_user.id == @investment_entry.user_id && params[:coin_name] != "" && params[:community] != "" && params[:code] != "" && params[:whitepaper] != ""
      @investment_entry.update(:coin_name => params[:coin_name], :community => params[:community], :code => params[:code], :whitepaper => params[:whitepaper])#, user_id: current_user.id, date: datetime)
      redirect "/investment_entries/#{@investment_entry.id}"
    else
      redirect "/investment_entries/#{@investment_entry.id}/edit"
    end
  end

  delete '/investment_entries/:id' do
    @investment_entry = InvestmentEntry.find(params[:id])
    if logged_in? && current_user.id == @investment_entry.user_id
      @investment_entry.destroy
      flash[:message] = "Successfully deleted that entry."
      redirect "/investment_entries"
    else
      redirect "/investment_entries"
    end
  end


end
