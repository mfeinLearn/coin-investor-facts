class CreateInvestments < ActiveRecord::Migration
  def change
    create_table :investments do |t|
      t.integer :score
      t.integer :startup_id, :default => true, :null => true
      t.integer :coin_id, :default => true, :null => true
    end
  end
end
