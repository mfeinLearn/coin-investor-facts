class User < ActiveRecord::Base
  validates :username, :email, :password, presence: true
  validates :email, uniqueness: true

  has_secure_password
  # bcrypt gives us this method - this allows us to use
# a activerecord method called authenticate.
# authenticate takes in a password which is a plan string
# and checks it agenst bcrypts hashing algurithum to make sure it is
# the correct password

# in forms and our controller we can say password when we
# want to refer to our password

  # ACTIVERECORD VALIDATIONS - adding more validations into our user model:

# validates is a method invocation
# name is the thing that is beign validated
# presence: true - key value pair
#  these validations will pervent ActiveRecord from:
#  - creation saving updating from the database if these requirements are not meet
  has_many :user_investment_entries
  has_many :investment_entries, through: :user_investment_entries

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
