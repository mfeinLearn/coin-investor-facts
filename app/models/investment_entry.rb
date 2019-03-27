class InvestmentEntry < ActiveRecord::Base
  has_many :user_investment_entries
  has_many :users, through: :user_investment_entries
  has_many :teams
end
