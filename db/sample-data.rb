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
