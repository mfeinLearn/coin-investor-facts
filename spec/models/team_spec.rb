require_relative '../spec_helper'

describe Team do
  before do
    @user = User.create(:username => "test 123", :email => "test123@aol.com", :password => "test")
  end

  describe 'associations' do

    it 'belongs to a InvestmentEntry' do
      #@user = User.create
      @team = Team.create
      datetime = DateTime.now
      investment_entry = InvestmentEntry.create(:coin_name => "ethereum", :community => "https://gitter.im/ethereum/home", :code => "https://github.com/ethereum", :whitepaper => "https://github.com/ethereum/wiki/wiki/White-Paper", :user_id => @user.id, :date => datetime)


      investment_entry.teams << @team

      expect(@team.investment_entry).to eq(investment_entry)
    end
  end
end
