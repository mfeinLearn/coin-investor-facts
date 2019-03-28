class Investment < ActiveRecord::Base
has_many :user_investment_entries
has_many :users, through: :user_investment_entries
belongs_to :coin
belongs_to :startup
end
