require 'spec_helper'
require 'pry'

describe ApplicationController do

  describe "Homepage" do
    it 'loads the homepage' do
      get '/'
      expect(last_response.status).to eq(200)
      expect(last_response.body).to include("Welcome to Coin investor Facts")
    end
  end

  describe "Signup Page" do

    it 'loads the signup page' do
      get '/signup'
      expect(last_response.status).to eq(200)
    end

    it 'signup directs user to investment entries index' do
      params = {
        :username => "skittles123",
        :email => "skittles@aol.com",
        :password => "rainbows"
      }
      post '/signup', params
      expect(last_response.location).to include("/investment_entries")
    end

    it 'does not let a user sign up without a username' do
      params = {
        :username => "",
        :email => "skittles@aol.com",
        :password => "rainbows"
      }
      post '/signup', params
      expect(last_response.location).to include('/signup')
    end

    it 'does not let a user sign up without an email' do
      params = {
        :username => "skittles123",
        :email => "",
        :password => "rainbows"
      }
      post '/signup', params
      expect(last_response.location).to include('/signup')
    end

    it 'does not let a user sign up without a password' do
      params = {
        :username => "skittles123",
        :email => "skittles@aol.com",
        :password => ""
      }
      post '/signup', params
      expect(last_response.location).to include('/signup')
    end

    it 'creates a new user and logs them in on valid submission and does not let a logged in user view the signup page' do
      params = {
        :username => "skittles123",
        :email => "skittles@aol.com",
        :password => "rainbows"
      }
      post '/signup', params
      get '/signup'
      expect(last_response.location).to include('/investment_entries')
    end
  end

  describe "login" do
    it 'loads the login page' do
      get '/login'
      expect(last_response.status).to eq(200)
    end

    it 'loads the investment entries index after login' do
      user = User.create(:username => "becky567", :email => "starz@aol.com", :password => "kittens")
      params = {
        :username => "becky567",
        :password => "kittens"
      }
      post '/login', params
      expect(last_response.status).to eq(302)
      follow_redirect!
      expect(last_response.status).to eq(200)
      expect(last_response.body).to include("Welcome,")
    end

    it 'does not let user view login page if already logged in' do
      user = User.create(:username => "becky567", :email => "starz@aol.com", :password => "kittens")
      params = {
        :username => "becky567",
        :password => "kittens"
      }
      post '/login', params
      get '/login'
      expect(last_response.location).to include("/investment_entries")
    end
  end

  describe "logout" do
    it "lets a user logout if they are already logged in" do
      user = User.create(:username => "becky567", :email => "starz@aol.com", :password => "kittens")

      params = {
        :username => "becky567",
        :password => "kittens"
      }
      post '/login', params
      get '/logout'
      expect(last_response.location).to include("/login")
    end

    it 'does not let a user logout if not logged in' do
      get '/logout'
      expect(last_response.location).to include("/")
    end

    it 'does not load /investment_entries if user not logged in' do
      get '/investment_entries'
      expect(last_response.location).to include("/login")
    end

    it 'does load /investment_entries if user is logged in' do
      user = User.create(:username => "becky567", :email => "starz@aol.com", :password => "kittens")


      visit '/login'

      fill_in(:username, :with => "becky567")
      fill_in(:password, :with => "kittens")
      click_button 'submit'
      expect(page.current_path).to eq('/investment_entries')
    end
  end

  describe 'user show page' do
    before do
      @user = User.create(:username => "test 123", :email => "test123@aol.com", :password => "test")
    end
    it 'shows all a single users investment entries' do
      datetime = DateTime.now
      investment_entry1 = InvestmentEntry.create(:coin_name => "SingularityNET", :community => "https://t.me/singularitynet", :code => "https://github.com/singnet", :whitepaper => "https://public.singularitynet.io/whitepaper.pdf", :user_id => @user.id, :date => datetime)
      investment_entry2 = InvestmentEntry.create(:coin_name => "Ethereum", :community => "https://gitter.im/ethereum/home", :code => "https://github.com/ethereum", :whitepaper => "https://github.com/ethereum/wiki/wiki/White-Paper", :user_id => @user.id, :date => datetime)
      get "/users/#{@user.slug}"

      expect(last_response.body).to include("SingularityNET")
      expect(last_response.body).to include("Ethereum")

    end
  end

  describe 'index action' do
    context 'logged in' do
      it 'lets a user view the investment entries index if logged in' do
        datetime = DateTime.now
        user1 = User.create(:username => "becky567", :email => "starz@aol.com", :password => "kittens")
        investment_entry1 = InvestmentEntry.create(:coin_name => "SingularityNET", :community => "https://t.me/singularitynet", :code => "https://github.com/singnet", :whitepaper => "https://public.singularitynet.io/whitepaper.pdf", :user_id => user1.id, :date => datetime)

        user2 = User.create(:username => "silverstallion", :email => "silver@aol.com", :password => "horses")
        investment_entry2 = InvestmentEntry.create(:coin_name => "Ethereum", :community => "https://gitter.im/ethereum/home", :code => "https://github.com/ethereum", :whitepaper => "https://github.com/ethereum/wiki/wiki/White-Paper", :user_id => user2.id, :date => datetime)


        visit '/login'

        fill_in(:username, :with => "becky567")
        fill_in(:password, :with => "kittens")
        click_button 'submit'
        visit "/investment_entries"
        expect(page.body).to include(investment_entry1.coin_name)
        expect(page.body).to include(investment_entry2.coin_name)
      end
     end

    context 'logged out' do
      it 'does not let a user view the investment entries index if not logged in' do
        get '/investment_entries'
        expect(last_response.location).to include("/login")
      end
    end
  end

  describe 'new action' do
    context 'logged in' do
      it 'lets user view new investment entry form if logged in' do
        user = User.create(:username => "becky567", :email => "starz@aol.com", :password => "kittens")

        visit '/login'

        fill_in(:username, :with => "becky567")
        fill_in(:password, :with => "kittens")
        click_button 'submit'
        visit '/investment_entries/new'
        expect(page.status_code).to eq(200)
      end

      it 'lets user create a investment entry if they are logged in' do
        user = User.create(:username => "becky567", :email => "starz@aol.com", :password => "kittens")
        datetime = DateTime.now

        visit '/login'

        fill_in(:username, :with => "becky567")
        fill_in(:password, :with => "kittens")
        click_button 'submit'

        visit '/investment_entries/new'
        fill_in(:coin_name, :with => "Ethereum")
        fill_in(:community, :with => "https://gitter.im/ethereum/home")
        fill_in(:code, :with => "https://github.com/ethereum")
        fill_in(:whitepaper, :with => "https://github.com/ethereum/wiki/wiki/White-Paper")
        click_button 'submit'

        user = User.find_by(:username => "becky567")
        investment_entry = InvestmentEntry.find_by(:coin_name => "Ethereum")
        expect(investment_entry).to be_instance_of(InvestmentEntry)
        expect(investment_entry.user_id).to eq(user.id)
        expect(page.status_code).to eq(200)
      end

      it 'does not let a user investment entry from another user' do
        user = User.create(:username => "becky567", :email => "starz@aol.com", :password => "kittens")
        user2 = User.create(:username => "silverstallion", :email => "silver@aol.com", :password => "horses")

        visit '/login'

        fill_in(:username, :with => "becky567")
        fill_in(:password, :with => "kittens")
        click_button 'submit'

        visit '/investment_entries/new'

        fill_in(:coin_name, :with => "Ethereum")
        fill_in(:community, :with => "https://gitter.im/ethereum/home")
        fill_in(:code, :with => "https://github.com/ethereum")
        fill_in(:whitepaper, :with => "https://github.com/ethereum/wiki/wiki/White-Paper")
        click_button 'submit'

        user = User.find_by(:id=> user.id)
        user2 = User.find_by(:id => user2.id)
        investment_entry = InvestmentEntry.find_by(:coin_name => "Ethereum")
        expect(investment_entry).to be_instance_of(InvestmentEntry)
        expect(investment_entry.user_id).to eq(user.id)
        expect(investment_entry.user_id).not_to eq(user2.id)
      end

      it 'does not let a user create a blank investment entry' do
        user = User.create(:username => "becky567", :email => "starz@aol.com", :password => "kittens")

        visit '/login'

        fill_in(:username, :with => "becky567")
        fill_in(:password, :with => "kittens")
        click_button 'submit'

        visit '/investment_entries/new'

        fill_in(:coin_name, :with => "")
        fill_in(:community, :with => "")
        fill_in(:code, :with => "")
        fill_in(:whitepaper, :with => "")
        click_button 'submit'

        expect(InvestmentEntry.find_by(coin_name: "", community: "", code: "", whitepaper: "")).to eq(nil)
        expect(page.current_path).to eq("/investment_entries/new")
      end
    end

    context 'logged out' do
      it 'does not let user view new investment entry form if not logged in' do
        get '/investment_entries/new'
        expect(last_response.location).to include("/login")
      end
    end
  end

  describe 'show action' do
    context 'logged in' do
      it 'displays a single investment entry' do

        user = User.create(:username => "becky567", :email => "starz@aol.com", :password => "kittens")
        datetime = DateTime.now
        investment_entry = InvestmentEntry.create(:coin_name => "SingularityNET", :community => "https://t.me/singularitynet", :code => "https://github.com/singnet", :whitepaper => "https://public.singularitynet.io/whitepaper.pdf", :user_id => user.id, :date => datetime)

        visit '/login'

        fill_in(:username, :with => "becky567")
        fill_in(:password, :with => "kittens")
        click_button 'submit'

        visit "/investment_entries/#{investment_entry.id}"
        expect(page.status_code).to eq(200)
        expect(page.body).to include("Delete Investment Entry")
        expect(page.body).to include(investment_entry.coin_name)
        expect(page.body).to include(investment_entry.community)
        expect(page.body).to include(investment_entry.code)
        expect(page.body).to include(investment_entry.whitepaper)
        expect(page.body).to include("Edit Investment Entry")
      end
    end

    context 'logged out' do
      it 'does not let a user view a investment entry' do
        user = User.create(:username => "becky567", :email => "starz@aol.com", :password => "kittens")
        datetime = DateTime.now
        investment_entry = InvestmentEntry.create(:coin_name => "SingularityNET", :community => "https://t.me/singularitynet", :code => "https://github.com/singnet", :whitepaper => "https://public.singularitynet.io/whitepaper.pdf", :user_id => user.id, :date => datetime)
        get "/investment_entries/#{investment_entry.id}"
        expect(last_response.location).to include("/login")
      end
    end
  end

  describe 'edit action' do
    context "logged in" do
      it 'lets a user view investment entry edit form if they are logged in' do
        user = User.create(:username => "becky567", :email => "starz@aol.com", :password => "kittens")
        datetime = DateTime.now
        investment_entry = InvestmentEntry.create(:coin_name => "SingularityNET", :community => "https://t.me/singularitynet", :code => "https://github.com/singnet", :whitepaper => "https://public.singularitynet.io/whitepaper.pdf", :user_id => user.id, :date => datetime)
        visit '/login'

        fill_in(:username, :with => "becky567")
        fill_in(:password, :with => "kittens")
        click_button 'submit'
        visit '/investment_entries/1/edit'
        expect(page.status_code).to eq(200)
        expect(page.body).to include(investment_entry.coin_name)
        expect(page.body).to include(investment_entry.community)
        expect(page.body).to include(investment_entry.code)
        expect(page.body).to include(investment_entry.whitepaper)
      end

      it 'does not let a user edit an investment entry they did not create' do
        datetime = DateTime.now

        user1 = User.create(:username => "becky567", :email => "starz@aol.com", :password => "kittens")
        investment_entry1 = InvestmentEntry.create(:coin_name => "SingularityNET", :community => "https://t.me/singularitynet", :code => "https://github.com/singnet", :whitepaper => "https://public.singularitynet.io/whitepaper.pdf", :user_id => user1.id, :date => datetime)

        user2 = User.create(:username => "silverstallion", :email => "silver@aol.com", :password => "horses")
        investment_entry2 = InvestmentEntry.create(:coin_name => "Ethereum", :community => "https://gitter.im/ethereum/home", :code => "https://github.com/ethereum", :whitepaper => "https://github.com/ethereum/wiki/wiki/White-Paper", :user_id => user2.id, :date => datetime)

        visit '/login'

        fill_in(:username, :with => "becky567")
        fill_in(:password, :with => "kittens")
        click_button 'submit'
        visit "/investment_entries/#{investment_entry2.id}/edit"
        expect(page.current_path).to include('/investment_entries')
      end

      it 'lets a user edit their own investment entry if they are logged in' do
        user = User.create(:username => "becky567", :email => "starz@aol.com", :password => "kittens")
        datetime = DateTime.now
        investment_entry = InvestmentEntry.create(:coin_name => "SingularityNET", :community => "https://t.me/singularitynet", :code => "https://github.com/singnet", :whitepaper => "https://public.singularitynet.io/whitepaper.pdf", :user_id => 1, :date => datetime)

        visit '/login'

        fill_in(:username, :with => "becky567")
        fill_in(:password, :with => "kittens")
        click_button 'submit'
        visit '/investment_entries/1/edit'

        fill_in(:coin_name, :with => "Ethereum")
        fill_in(:community, :with => "https://gitter.im/ethereum/home")
        fill_in(:code, :with => "https://github.com/ethereum")
        fill_in(:whitepaper, :with => "https://github.com/ethereum/wiki/wiki/White-Paper")


        click_button "submit"
        expect(InvestmentEntry.find_by(coin_name: "Ethereum", community: "https://gitter.im/ethereum/home", code: "https://github.com/ethereum", whitepaper: "https://github.com/ethereum/wiki/wiki/White-Paper")).to be_instance_of(InvestmentEntry)
        expect(InvestmentEntry.find_by(coin_name: "SingularityNET", community: "https://t.me/singularitynet", code: "https://github.com/singnet", whitepaper: "https://public.singularitynet.io/whitepaper.pdf")).to eq(nil)
        expect(page.status_code).to eq(200)
      end

      it 'does not let a user edit a text with blank coin_name, community, code, and whitepaper' do
        user = User.create(:username => "becky567", :email => "starz@aol.com", :password => "kittens")
        datetime = DateTime.now
        investment_entry = InvestmentEntry.create(:coin_name => "SingularityNET", :community => "https://t.me/singularitynet", :code => "https://github.com/singnet", :whitepaper => "https://public.singularitynet.io/whitepaper.pdf", :user_id => 1, :date => datetime)
        visit '/login'

        fill_in(:username, :with => "becky567")
        fill_in(:password, :with => "kittens")
        click_button 'submit'
        visit '/investment_entries/1/edit'

        fill_in(:coin_name, :with => "")
        fill_in(:community, :with => "")
        fill_in(:code, :with => "")
        fill_in(:whitepaper, :with => "")

        click_button 'submit'
        expect(InvestmentEntry.find_by(:coin_name => "Ethereum", :community => "https://gitter.im/ethereum/home", :code => "https://github.com/ethereum", :whitepaper => "https://github.com/ethereum/wiki/wiki/White-Paper")).to eq(nil)
        expect(page.current_path).to eq("/investment_entries/1/edit")
      end
    end

    context "logged out" do
      it 'does not load -- instead redirects to login'# do
      #   get '/tweets/1/edit'
      #   expect(last_response.location).to include("/login")
      # end
    end
  end

  describe 'delete action' do
    context "logged in" do
      it 'lets a user delete their own investment entry if they are logged in' #do
      #   user = User.create(:username => "becky567", :email => "starz@aol.com", :password => "kittens")
      #   tweet = Tweet.create(:content => "tweeting!", :user_id => 1)
      #   visit '/login'
      #
      #   fill_in(:username, :with => "becky567")
      #   fill_in(:password, :with => "kittens")
      #   click_button 'submit'
      #   visit 'tweets/1'
      #   click_button "Delete Tweet"
      #   expect(page.status_code).to eq(200)
      #   expect(Tweet.find_by(:content => "tweeting!")).to eq(nil)
      # end

      it 'does not let a user delete a investment entry they did not create' #do
      #   user1 = User.create(:username => "becky567", :email => "starz@aol.com", :password => "kittens")
      #   tweet1 = Tweet.create(:content => "tweeting!", :user_id => user1.id)
      #
      #   user2 = User.create(:username => "silverstallion", :email => "silver@aol.com", :password => "horses")
      #   tweet2 = Tweet.create(:content => "look at this tweet", :user_id => user2.id)
      #
      #   visit '/login'
      #
      #   fill_in(:username, :with => "becky567")
      #   fill_in(:password, :with => "kittens")
      #   click_button 'submit'
      #   visit "tweets/#{tweet2.id}"
      #   click_button "Delete Tweet"
      #   expect(page.status_code).to eq(200)
      #   expect(Tweet.find_by(:content => "look at this tweet")).to be_instance_of(Tweet)
      #   expect(page.current_path).to include('/tweets')
      # end
    end

    context "logged out" do
      it 'does not load let user delete a investment entry if not logged in' #do
      #   tweet = Tweet.create(:content => "tweeting!", :user_id => 1)
      #   visit '/tweets/1'
      #   expect(page.current_path).to eq("/login")
      # end
    end
  end
 end
