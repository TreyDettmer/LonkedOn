class AddUserIdToSocialPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :social_posts, :user_id, :integer
  end
end
