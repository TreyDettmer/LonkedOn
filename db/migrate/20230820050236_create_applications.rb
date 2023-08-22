class CreateApplications < ActiveRecord::Migration[7.0]
  def change
    create_table :applications do |t|
      t.references :user, null: false, foreign_key: true
      t.references :job_post, null: false, foreign_key: true

      t.timestamps
    end
    add_index :applications, [:user_id, :job_post_id], unique: true
  end
end
