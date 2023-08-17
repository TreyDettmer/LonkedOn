class ChangeDescriptionToBeTextInJobPosts < ActiveRecord::Migration[7.0]
  def up
    change_column :job_posts, :description, :text
  end

  def down
    change_column :job_posts, :description, :string
  end
end
