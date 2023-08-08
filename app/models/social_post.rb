class SocialPost < ApplicationRecord
    has_one_attached :image
    belongs_to :user
    acts_as_punchable

    has_many :likes
end
