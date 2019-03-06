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

## User

## Attributes

- name
- email
- password (if I use bcrypt, this will be 'password_digest' in the database)

## Associations
has_many :investment_enties

## InvestmentEntry

## Attributes
- :content =>
{
  name,
  team,
  community_number,
  code,
  whitepaper
}
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
- Users can see update news regarding regulation in the layout
