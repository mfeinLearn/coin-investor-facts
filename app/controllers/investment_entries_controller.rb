# class InvestmentEntriesController < ApplicationController
#
#
#   get '/investment_entries' do
#     if logged_in?
#
#       @startups = Startup.all
#       @coins = Coin.all
#
#       #@investment_entries = InvestmentEntry.all
#       #binding.pry
#
#       erb :'/investment_entries/index'
#     else
#       redirect "/login"
#     end
#   end
#
#   get'/investment_entries/new' do
#     if logged_in?
#       erb :'/investment_entries/new'
#     else
#       redirect "/login"
#     end
#     #display a form for creation
#   end
#
#   post '/investment_entries' do
#     redirect_if_not_logged_in
#     if params[:coin_name] != "" && params[:community] != "" && params[:code] != "" && params[:whitepaper] != "" && params[:user_id] != "" && params[:date] != "" #&& params[:team0] != ""
#       datetime = DateTime.now
#       #raise params.inspect
#       #
#       # params =>  {"coin_name"=>"appleCoin",
#       #             "community"=>"appleCommunity",
#       #             "code"=>"appleCode",
#       #             "whitepaper"=>"github.com/appleCoin/appleWhitepaper",
#       #             "team0"=>"Mr. Apple",
#       #             "team1"=>"Miss. Apple",
#       #             "team2"=>"",
#       #             "team3"=>"",
#       #             "submit"=>"Create Investment Entry"}
#       #
#       # to use params to create a new resource(investment_entry & Team)
#       # - the value of the name attribute in the new.erb view
#       #  needs to be used as the key for the params hash to get access
#       # to the value which is what the user typed into the form.
#       @investment_entry = InvestmentEntry.create(coin_name: params[:coin_name], community: params[:community], code: params[:code], whitepaper: params[:whitepaper], user_id: current_user.id, date: datetime)
#       # raise params.inspect
#       #1. Thanks to activerecord we get access to the collection of
#       #     teams from the investment_entry object that has many teams.
#       #2. That puts each Team into the teams array.
#
#       @investment_entry.teams << Team.create(name: params[:team0])
#       @investment_entry.teams << Team.create(name: params[:team1])
#       @investment_entry.teams << Team.create(name: params[:team2])
#       @investment_entry.teams << Team.create(name: params[:team3])
#       # 3. Saves the investment_entry object which saves the investment_entry's children
#       # which is the Team objects
#       @investment_entry.save
#       #binding.pry
#       #raise params.inspect
#       #
#       flash[:message] = "Investment Entry successfully created." if @investment_entry.id
#       redirect "/investment_entries"
#     else
#       flash[:errors] = "Something went wrong - you must provide content for your entry."
#       redirect '/investment_entries/new'
#     end
#   end
#
#
#   get '/investment_entries/:id' do
#     if logged_in?
#       set_investment_entry
#       erb :'/investment_entries/show'
#    else
#      redirect "/login"
#    end
#   end
#   #
#   #
#   get '/investment_entries/:id/edit' do
#       set_investment_entry
#       redirect_if_not_logged_in
#     if authorized_to_edit?(@investment_entry)
#       erb :'/investment_entries/edit'
#     else
#       redirect "/login"
#     end
#   end
#
#   patch '/investment_entries/:id' do
#     set_investment_entry
#     redirect_if_not_logged_in
#     #raise params.inspect
#     if current_user.id == @investment_entry.user_id && params[:coin_name] != "" && params[:community] != "" && params[:code] != "" && params[:whitepaper] != "" # && params[:team0] != ""
#       @investment_entry.update(:coin_name => params[:coin_name], :community => params[:community], :code => params[:code], :whitepaper => params[:whitepaper])#, user_id: current_user.id, date: datetime)
#       #update -It job is to:
#       # an Active Record object has been retrieved,
#       # its attributes can be modified and it can be saved to the database
#       # with update key value pairs has to be used to update an object's attribute
#       @investment_entry.teams[0].update(:name => params[:team0])
#       @investment_entry.teams[1].update(:name => params[:team1])
#       @investment_entry.teams[2].update(:name => params[:team2])
#       @investment_entry.teams[3].update(:name => params[:team3])
#       #binding.pry
#       @investment_entry.save
#       redirect "/investment_entries/#{@investment_entry.id}"
#     else
#       redirect "/investment_entries/#{@investment_entry.id}/edit"
#     end
#   end
#
#   delete '/investment_entries/:id' do
#     set_investment_entry
#     if logged_in? && current_user.id == @investment_entry.user_id
#       @investment_entry.destroy
#       flash[:message] = "Successfully deleted that entry."
#       redirect "/investment_entries"
#     else
#       redirect "/investment_entries"
#     end
#   end
#
#     private # it is something that we are not
#   # going to called outside of this class
#
#   def set_investment_entry
#     datetime = DateTime.now
#     @investment_entry = InvestmentEntry.find(params[:id])
#   end
#
#
# end
# ###### ############ helpful to note ###### ############
# # GET request:
# # get request will show something that exist
# # - this job is to showing us something!
#
# # POST request:
# # post request will create something in a certian way specified by the client through params
# ############ ############ ############ ############ ############
# # dynamic route:
# # the dynamic route the symbol of the
# # route is the key of the value which is typed into the url
# # dynamic route: The dynamic pieces in the route becomes key value pairs in the params hash
# # Ex.
# # get '/investment_entries/:id' do
# # get '/investment_entries/1' do
# # params hash :id => 1
# ############ ############ ############ ############ ############
# # redirect:
# # when we redirect we send a brand new get request
# # when that happens all of the varables created within the block
# #   that we are passing within this paticular controller route/
# #   within this paticular action gets enialiated(redirects destroy
# #   instance varables)
# ############ ############ ############ ############ ############
# # erb:
# #   To keep the instance varable alive to be able to be alive in
# #   the show page - we can erb/render!!!!!
# #
# #   erb is a method in sanatra that calls another method called render
# #   erb wants a name of a file reference from our views
# ############ ############ ############ ############ ############
# # method calling:
# # Note: method invocations are inside of the controllers
# ############ ############ ############ ############ ############
# # Delete:
# # An activerecord Delete - pluck that thing out
# ############ ############ ############ ############ ############
# # usually:
# # delete, patch and post request actions- USUALLY end in redirects
# ############ ############ ############ ############ ############
#
# ##### ******* controller action = IS TO ONLY DO **ONE SHIT***/ THING ******* ######
# # get request ends in erb BECAUSE we need to show somwthing!!!! ###
