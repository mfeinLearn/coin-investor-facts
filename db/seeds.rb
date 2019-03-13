# here is where I will create some seed data to work with and test associations

# Create 2 users

 homer = User.create(username: "Howard", email: "homer@simpson.com", password: "password")

# Create some investment entries
 datetime = DateTime.now
 investment_entry1 = InvestmentEntry.create(:coin_name => "SingularityNET", :community => "https://t.me/singularitynet", :code => "https://github.com/singnet", :whitepaper => "https://public.singularitynet.io/whitepaper.pdf", :user_id => homer.id, :date => datetime)

# Use AR to per-associate data:

 homer.investment_entries.create(:coin_name => "Ethereum", :community => "https://gitter.im/ethereum/home", :code => "https://github.com/ethereum", :whitepaper => "https://github.com/ethereum/wiki/wiki/White-Paper", :user_id => homer.id, :date => datetime)

 #sherrys_entry = sherry.journal_entries.build(title: "Cold VA", content: "It's super cold in VA!!")
 #sherrys_entry.save

# characters:
#
# Stan Marsh
# Kyle Broflovski
# Eric Cartman
# Kenny McCormick
#
# Philip J. Fry
# Turanga Leela
# Bender
# Professor Farnsworth
# Hermes Conrad
# Doctor Zoidberg
# Amy Wong
