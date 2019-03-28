class CreateUserInvestmentEntries < ActiveRecord::Migration
  def change
    create_table :user_investment_entries do |t|
      t.integer :user_id
      t.integer :startup_id, :default => true, :null => true
      t.integer :coin_id, :default => true, :null => true
      t.integer :score
    end
  end
end
