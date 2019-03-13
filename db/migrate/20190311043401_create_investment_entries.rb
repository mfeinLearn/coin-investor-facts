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
