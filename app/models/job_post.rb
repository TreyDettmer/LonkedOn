class JobPost < ApplicationRecord
    belongs_to :company
    before_create :randomize_id
    has_many :applications, dependent: :destroy
    private
    def randomize_id
        begin
          self.id = SecureRandom.random_number(1_000_000_000)
        end while User.where(id: self.id).exists?
    end
end
