class CreateWorkExperiences < ActiveRecord::Migration[7.0]
  def change
    create_table :work_experiences do |t|
      t.references :user, null: false, foreign_key: true
      t.references :company, null: false, foreign_key: true
      t.string :title
      t.string :location
      t.text :description
      t.date :start_date
      t.date :end_date
      t.timestamps
    end
  end
end
