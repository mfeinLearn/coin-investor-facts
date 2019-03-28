coin: Stellar
community: https://stellarcommunity.org/
code: https://github.com/stellar
whitepaper: https://www.stellar.org/papers/stellar-consensus-protocol.pdf
team: Jed McCaleb Joyce Kim

coin: TRON
community: https://t.me/tronnetworkEN
code: https://github.com/tronprotocol
whitepaper: https://developers.tron.network/docs
team: Justin Sun

<% @investment_entry.teams.each do |team| %>
  <label>A founding team member:</label>
  <input type="text" name="name" value="<%= team.name %>">
  <!-- <label>Another founding team member:</label> -->
  <!-- <input type="text" name="team1" value="<%# team.name %>">
  <label>Another founding team member:</label>
  <input type="text" name="team2" value="<%# team.name %>">
  <label>Another founding team member:</label>
  <input type="text" name="team3" value="<%# team.name %>"> -->
<% end %>


class CreateInvestmentEntries < ActiveRecord::Migration
  def change
    create_table :investment_entries do |t|
      t.string :coin_name
      t.string :community
      t.string :code
      t.string :whitepaper
      t.integer :user_id
      t.datetime :date
    end
  end
end
Company
Innovation
Growth
Product
Team
Structure
Resources
Partnerships
Uncertainties
create_table :startups do |t|
  t.string :company_name
  t.string :innovation
  t.string :growth
  t.string :product
  t.integer :team
  t.datetime :structure
  t.string :resources
  t.integer :partnerships
  t.datetime :uncertainties
end
