class UserInvestmentEntry < ActiveRecord::Base
  belongs_to :user
  belongs_to :investment
end
