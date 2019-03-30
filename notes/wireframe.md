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
id username   email            password
_______________________________________
1| "bob"  | "bob@bob.com"   | password_digest |
2| jim  | jim@jim.com   | password_digest |
3| atom | atom@atom.com | password_digest |
----------------------------------------





## Attributes

- username
- email
- password (if I use bcrypt, this will be 'password_digest' in the database)

## Associations
has_many :investment_enties
-------------------------------------------------------------------------------------
## InvestmentEntry
Table: investment_entries


id coin_name community       code      whitepaper      user_id   date
________________________________________________________________________
1| eth  |  gitter.im  | github.com | whitepaper_link  | 1 | datetime |
2| agi  |  t.bit      | github.com | whitepaper_link  | 2 | datetime |
3| tron |  t.bit      | github.com | whitepaper_link  | 3 | datetime |
------------------------------------------------------------------------
Vitalik Buterin   
Patrick Storchenegger
 Jeffrey Wilcke  

## Attributes
- coin_name
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
4| someone_1              | 2   |
5| someone_2              | 2   |
6| someone_3              | 2   |
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
  see in extra branch for more info: https://github.com/mfeinLearn/coin-investor-facts/tree/extra
- Include a join model ->done
- Include a Investment model - users have different Investments and a Investment has many Entries
  -> done-ish(I just added two models for investments)
  - Abstract away investment_entries to enable people to invest in other asset classes - Done-ish
  (asset classes = coin)   

######VERY BIG STRETCH GOAL######
- Users can see update news regarding regulation in the layout
- CSS - make it look really nice

######CURRENT ISSUES######
- authenticate is not set up properly yet!
- controllers and views are: still in progress

=> look at the following for reference:
https://github.com/mfeinLearn/coin-investor-facts 
https://github.com/mfeinLearn/nyc-sinatra-v-000



############################ investment big picture ########################################
                            investment
                             --below--
                            ,,,,,,,,,,
                            , c1     ,
                            ,  c2    ,
***investment_enties****  = ,,,,,,,,,,
############################ investment big picture ########################################


########################### 'The abstraction' ########################################################
users-<investment_entries(coins)-<teams(board members)
(asset classes = ++++coin++++, equity, gold, real estate)
########################### 'The abstraction' ########################################################
