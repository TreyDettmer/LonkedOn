class SocialPost < ApplicationRecord
    has_one_attached :image
    belongs_to :user
    acts_as_punchable

    has_many :likes, dependent: :destroy

    before_create :randomize_id

    private
    
    def randomize_id
      begin
        self.id = SecureRandom.random_number(1_000_000_000)
      end while User.where(id: self.id).exists?
    end
end
