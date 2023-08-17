class CreateCompanies < ActiveRecord::Migration[7.0]
  def change
    create_table :companies do |t|
      t.string :title
      t.string :location, default: ''
      t.timestamps
    end
  end
end
