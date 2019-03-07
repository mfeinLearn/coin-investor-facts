# App Overview

I am going to build an investment app, where a user can create Investment Entries(coins).

# User Stories

## As a user, I will be able to…
- log in, signup, logout
- create a Investment entry
- see all my Investment Entries
- edit my Investment Entries
- delete my Investment Entries

# Wireframe

## Models will be - User and InvestmentEntry
-------------------------------------------------------------------------------------

## User
Table: users
id name   email            password
_______________________________________
1| bob  | bob@bob.com   | password_digest |
2| jim  | jim@jim.com   | password_digest |
3| atom | atom@atom.com | password_digest |
----------------------------------------

## Attributes

- name
- email
- password (if I use bcrypt, this will be 'password_digest' in the database)

## Associations
has_many :investment_enties
-------------------------------------------------------------------------------------
## InvestmentEntry
Table: investment_entries


id name team_id community       code      whitepaper      user_id   date
________________________________________________________________________
1| eth  | 1 |  gitter.im  | github.com | whitepaper_link  | 1 | datetime |
2| agi  | 2 |  t.bit      | github.com | whitepaper_link  | 2 | datetime |
3| tron | 3 |  t.bit      | github.com | whitepaper_link  | 3 | datetime |
------------------------------------------------------------------------

## Attributes
- name
- team
- community
- code
- whitepaper
- user_id <-- this will be the foreign key!
- date

## Associations
belongs_to :user

-------------------------------------------------------------------------------------


## Team
teams
     name                  investment_entry_id
_______________________________________
1| Vitalik Buterin        | 1   |
2| Patrick Storchenegger  | 1   |
3| Jeffrey Wilcke         | 1   |
4| someone_1              | ?   |
5| someone_2              | ?   |
6| someone_3              | ?   |
----------------------------------------

## Attributes
- name
- investment_entry_id

## Associations
belongs_to :investment_entry

-------------------------------------------------------------------------------------


# MVP

Users can signup, log in, logout, create Investment entries, edit their own entries, and
view their entries

# Stretch Goals

- CSS - make it look really nice
- Tests
- Include a join model
- Include a Investment model - users have different Investments and a Investment has many Entries
- Users can see update news regarding regulation in the layout
######VERY BIG STRETCH GOAL######
- Abstract away investment_entries to enable people to invest in other asset classes
(asset classes = coin, equity, gold, real estate)



######################## 'TEAMS' ##############################################################

# list out all of the team members associated with the investment_entry in question
investment_entries.each do |investment_entry|
  investment_entry.teams.find_all do |team|
    Team.all.investment_entry_id == team.investment_entry_id
  end
end
########################### 'TEAMS' ###########################################################

############################ investment big picture ########################################
                            investment
                             --below--
                            ,,,,,,,,,,
                            , c1     ,
                            ,  c2    ,
***investment_enties****  = ,,,,,,,,,,

########################### investment big picture #########################################


DIAGRAM:
users-<investment_entries-<teams

associations:
malcome = User.create(name: "malcome", email: "malcome@malcome.com", password:"Hashed")
eth = InvestmentEntry.create(name: params[:name], team: params[:team], community: params[:community], code: params[:code], whitepaper: params[:whitepaper], user_id: params[:user_id], date: params[:date])
vic = Team.create(name: params[:name])


########################### 'The abstraction' ########################################################
users-<investment_entries(coins)-<teams(board members)
(asset classes = coin, equity, gold, real estate)
########################### 'The abstraction' ########################################################
