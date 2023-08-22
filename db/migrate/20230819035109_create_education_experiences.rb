class CreateEducationExperiences < ActiveRecord::Migration[7.0]
  def change
    create_table :education_experiences do |t|
      t.references :user, null: false, foreign_key: true
      t.string :school
      t.string :degree
      t.string :field_of_study
      t.date :start_date
      t.date :end_date
      t.text :description
      t.timestamps
    end
  end
end
