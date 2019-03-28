class Startup < ActiveRecord::Base
  has_many :investments
  has_many :teams
end
