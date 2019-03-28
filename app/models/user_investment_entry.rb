class UserInvestmentEntry < ActiveRecord::Base
  belongs_to :user
  belongs_to :coin
  belongs_to :startup

end
