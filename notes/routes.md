
#### Index Action ####
```ruby
get '/investment_entries' do
  if logged_in?
    @investment_entries = InvestmentEntry.all
    erb :'/investment_entries/index'
  else
    redirect "/login"
  end
end
```


> The controller action above is doing the following:
responds to a GET request to the route '/investment_entries'.
This action is the index action: allows the view to access all the investment_entries in the database through the instance variable @investment_entries.


#### New Action ####
```ruby
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

      @investment_entry.teams << Team.create(name: params[:team0])
      @investment_entry.teams << Team.create(name: params[:team1])
      @investment_entry.teams << Team.create(name: params[:team2])
      @investment_entry.teams << Team.create(name: params[:team3])
      @investment_entry.save
      
      flash[:message] = "Investment Entry successfully created." if @investment_entry.id
      redirect "/investment_entries"
    else
      flash[:errors] = "Something went wrong - you must provide content for your entry."
      redirect '/investment_entries/new'
    end
  end

```
> Their is two controller actions above. The first one is a GET request to load the form to create a new investment_entry. The second action is the create action. This action responds to a POST request and creates a new investment_entry based on the params from the form and saves it to the database. Once the item is created, this action redirects to the show page.

#### Show Action ####
```ruby
  get '/investment_entries/:id' do
    if logged_in?
    datetime = DateTime.now
    @investment_entry = InvestmentEntry.find(params[:id])
      erb :'/investment_entries/show'
   else
     redirect "/login"
   end
  end
```
> The controller action above is called the show action. To display a single investment_entry, we need a show action. This controller action responds to a GET request to the route '/investment_entries/:id'. Because this route uses a dynamic URL, we can access the ID of the article in the view through the params hash.

#### Edit Action ####
```ruby
  get '/investment_entries/:id/edit' do
    datetime = DateTime.now
    @investment_entry = InvestmentEntry.find(params[:id])
      redirect_if_not_logged_in
    if authorized_to_edit?(@investment_entry)
      erb :'/investment_entries/edit'
    else
      redirect "/login"
    end
  end

  patch '/investment_entries/:id' do
    datetime = DateTime.now
    @investment_entry = InvestmentEntry.find(params[:id])
    redirect_if_not_logged_in
    #raise params.inspect
    if current_user.id == @investment_entry.user_id && params[:coin_name] != "" && params[:community] != "" && params[:code] != "" && params[:whitepaper] != "" # && params[:team0] != ""
      @investment_entry.update(:coin_name => params[:coin_name], :community => params[:community], :code => params[:code], :whitepaper => params[:whitepaper])#, user_id: current_user.id, date: datetime)
      @investment_entry.teams[0].update(:name => params[:team0])
      @investment_entry.teams[1].update(:name => params[:team1])
      @investment_entry.teams[2].update(:name => params[:team2])
      @investment_entry.teams[3].update(:name => params[:team3])
      #binding.pry
      @investment_entry.save
      redirect "/investment_entries/#{@investment_entry.id}"
    else
      redirect "/investment_entries/#{@investment_entry.id}/edit"
    end
  end
```

> The first controller action above loads the edit form in the browser by making a GET request to articles/:id/edit.
The second controller action has the job of editing for submissions. This action responds to a patch request to the route
/investment_entries/:id.
1. First, we pull the investment_entry by the ID from the URL
2. Second, we update the coin_name, community, code, and the whitepaper attributes and save them to the database.
3. Then action ends with a redirect to the article show page.

#### Delete Action ####
```ruby
  delete '/investment_entries/:id' do
    datetime = DateTime.now
    @investment_entry = InvestmentEntry.find(params[:id])
    if logged_in? && current_user.id == @investment_entry.user_id
      @investment_entry.destroy
      flash[:message] = "Successfully deleted that entry."
      redirect "/investment_entries"
    else
      redirect "/investment_entries"
    end
  end
```

> On the investment_entry show page, we have a form to delete it. The form is submitted via a DELETE request to the route
/investment_entries/:id/delete. This action finds the investment_entry in the database based on the ID in the url parameters, and deletes it. It then redirects to the index page
/investment_entries.


*The information on this topic was inspired by the following post: https://learn.co/lessons/sinatra-cms-app-assessment*
