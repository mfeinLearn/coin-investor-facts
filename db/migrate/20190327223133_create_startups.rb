class CreateStartups < ActiveRecord::Migration
  def change
    create_table :startups do |t|
      t.string :company_name
      t.string :innovation
      t.string :growth
      t.string :product
      t.integer :team_id
      t.string :structure
      t.string :resource
      t.string :partnerships
      t.string :uncertainties
    end
  end
end
