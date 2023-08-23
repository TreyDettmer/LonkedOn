class Application < ApplicationRecord
  belongs_to :user
  belongs_to :job_post

  # make sure no user can apply to the same job twice
  validates :user_id, uniqueness: {scope: :job_post_id}

end
