class CreateSocialPosts < ActiveRecord::Migration[7.0]
  def change
    create_table :social_posts do |t|
      t.string :title
      t.text :content

      t.timestamps
    end
  end
end
