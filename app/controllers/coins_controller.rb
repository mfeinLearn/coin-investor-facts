class CoinsController < ApplicationController


    get '/coins' do
      if logged_in?
        @coins = Coin.all
        erb :'/coins/index'
      else
        redirect "/login"
      end
    end

    get'/coins/new' do
      if logged_in?
        erb :'/coins/new'
      else
        redirect "/login"
      end
      #display a form for creation
    end

    post '/coins' do
      redirect_if_not_logged_in
      if params[:coin_name] != "" && params[:community] != "" && params[:code] != "" && params[:whitepaper] != "" && params[:user_id] != "" && params[:date] != ""
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
        @coin = Coin.create(coin_name: params[:coin_name], community: params[:community], code: params[:code], whitepaper: params[:whitepaper], user_id: current_user.id, date: datetime)
        # raise params.inspect
        #1. Thanks to activerecord we get access to the collection of
        #     teams from the investment_entry object that has many teams.
        #2. That puts each Team into the teams array.

        @coin.teams << Team.create(name: params[:team0])
        @coin.teams << Team.create(name: params[:team1])
        @coin.teams << Team.create(name: params[:team2])
        @coin.teams << Team.create(name: params[:team3])
        # 3. Saves the investment_entry object which saves the investment_entry's children
        # which is the Team objects
        @coin.save
        #binding.pry
        #raise params.inspect
        #
        flash[:message] = "Coin successfully created." if @coin.id
        redirect "/coins"
      else
        flash[:errors] = "Something went wrong - you must provide content for your coin."
        redirect '/coins/new'
      end
    end


    get '/coins/:id' do
      if logged_in?
        set_coin
        erb :'/coins/show'
     else
       redirect "/login"
     end
    end
    #
    #
    get '/coins/:id/edit' do
        set_coin
        redirect_if_not_logged_in
        # add authentication logic
        erb :'/coins/edit'
    end

    patch '/coins/:id' do
      set_coin
      redirect_if_not_logged_in
      #raise params.inspect
      if current_user.id == @coin.user_id && params[:coin_name] != "" && params[:community] != "" && params[:code] != "" && params[:whitepaper] != "" # && params[:team0] != ""
        @coin.update(:coin_name => params[:coin_name], :community => params[:community], :code => params[:code], :whitepaper => params[:whitepaper])#, user_id: current_user.id, date: datetime)
        #update -It job is to:
        # an Active Record object has been retrieved,
        # its attributes can be modified and it can be saved to the database
        # with update key value pairs has to be used to update an object's attribute
        @coin.teams[0].update(:name => params[:team0])
        @coin.teams[1].update(:name => params[:team1])
        @coin.teams[2].update(:name => params[:team2])
        @coin.teams[3].update(:name => params[:team3])
        #binding.pry
        @coin.save
        redirect "/coins/#{@coin.id}"
      else
        redirect "/coins/#{@coin.id}/edit"
      end
    end

    delete '/coins/:id' do
      set_coin
      if logged_in? && current_user.id == @coin.user_id
        @coin.destroy
        flash[:message] = "Successfully deleted that coin."
        redirect "/coins"
      else
        redirect "/coins"
      end
    end

      private # it is something that we are not
    # going to called outside of this class

    def set_coin
      datetime = DateTime.now
      @coin = Coin.find(params[:id])
    end


end
