class CreateUserInvestmentEntries < ActiveRecord::Migration
  def change
    create_table :user_investment_entries do |t|
      t.integer :user_id
      t.integer :investment_entry_id
    end
  end
end
