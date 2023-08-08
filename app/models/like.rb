class Like < ApplicationRecord
  belongs_to :user
  belongs_to :social_post

  # make sure no user can like the same post twice
  validates :user_id, uniqueness: {scope: :social_post_id}
end
