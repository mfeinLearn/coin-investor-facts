class User < ActiveRecord::Base
  validates :username, :email, :password, presence: true
  validates :email, uniqueness: true
  
  has_secure_password
  has_many :investment_entries

  def slug
    #binding.pry
     my_slug = self.username.gsub(" ", "-").downcase
  end

  def self.find_by_slug(slug)
    all.map {|u| if u.slug == slug
                return u
                end}
  end

end
