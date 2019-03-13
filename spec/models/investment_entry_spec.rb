require_relative '../spec_helper'

describe InvestmentEntry do
   before(:each) do
     @investment_entry = InvestmentEntry.new
     # this enables us to use the same piece of code inside our
     # test. So I dont have to create a new cart everytime inside
     # my it blocks
   end


  describe 'associations' do
    it 'belongs to a user' do
     @investment_entry = InvestmentEntry.create
     user = User.create(:username => "test 123", :email => "test123@aol.com", :password => "test")

     user.investment_entries << @investment_entry

     expect(@investment_entry.user).to eq(user)
    end
  end

end
