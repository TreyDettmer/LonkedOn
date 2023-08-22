class Company < ApplicationRecord
    has_one_attached :image
    has_many :job_posts, dependent: :destroy
    has_many :work_experiences, dependent: :destroy
end
