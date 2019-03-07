# App Overview

I am going to build an investment app, where a user can create Investment Entries(coins).
user -< InvestmentEntry

                            ,,,,,,,,,,
                            , c1     ,
                            ,  c2    ,
***investment_enties****  = ,,,,,,,,,,




# User Stories

## As a user, I will be able to…
- log in, signup, logout
- create a Investment entry
- see all my Investment Entries
- edit my Investment Entries
- delete my Investment Entries

# Wireframe

## Models will be - User and InvestmentEntry

## User
users
_______________________________________
1| bob  | bob@bob.com   | password |
2| jim  | jim@jim.com   | password |
3| atom | atom@atom.com | password |
----------------------------------------

## Attributes

- name
- email
- password (if I use bcrypt, this will be 'password_digest' in the database)

## Associations
has_many :investment_enties

## InvestmentEntry
investment_entries
_______________________________________
1| eth  | Vitalik Buterin, Patrick Storchenegger, Jeffrey Wilcke   | password | eth  | bob@bob.com   | password | password |
2| agi  | jim@jim.com   | password | agi  | jim@jim.com   | password | password |
3| tron | atom@atom.com | password | tron | atom@atom.com | password | password |
----------------------------------------

## Attributes
- name
- team
- community_number
- code
- whitepaper
- user_id <-- this will be the foreign key!
- date <-- is this a stretch goal?

## Associations
belongs_to :user

# MVP

Users can signup, log in, logout, create Investment entries, edit their own entries, and
view their entries

# Stretch Goals

- CSS - make it look really nice
- Tests
- Include a join model
- Include a Investment model - users have different Investments and a Investment has many Entries
- Include a  (user_investments)
- Users can see update news regarding regulation in the layout



------------------
#example of Attributes:
------------------

- :content =>
{
  name = "",
  team = "",
  community_number = "",
  code = "",
  whitepaper = ""
}
example:
  params[:content][:name]
  params[:content][:team]
  params[:content][:community_number]
  params[:content][:code]
  params[:content][:whitepaper]
---------------------------

user_investments
user | investments
1    | coin
------------------
1    | coin
-------------------
1    | coin
-------------------
1    | coin
user -< user_investments -< investments -< coins
                      asset classes = coin, equity, gold, real estate
