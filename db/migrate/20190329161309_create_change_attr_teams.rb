class CreateChangeAttrTeams < ActiveRecord::Migration
  def change
    remove_column :teams, :investment_entry_id
    add_column :teams, :startup_id, :integer
    add_column :teams, :coin_id, :integer
  end
end
