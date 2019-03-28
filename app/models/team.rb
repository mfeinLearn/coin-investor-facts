class Team < ActiveRecord::Base
  belongs_to :startup
  belongs_to :coin
end
