class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         followability
         has_many :social_posts, dependent: :destroy
         has_one_attached :avatar
         has_one_attached :backdrop
         has_many :likes, dependent: :destroy
         has_many :comments, dependent: :destroy
         has_many :work_experiences, dependent: :destroy
         has_many :education_experiences, dependent: :destroy
         has_many :applications, dependent: :destroy

  validates :first_name, presence: true
  validates :last_name, presence: true

  def self.ransackable_attributes(auth_object = nil)
    ["first_name", "last_name","full_name"]
  end

  ransacker :full_name do |parent|
    Arel::Nodes::InfixOperation.new(
      '||',
      Arel::Nodes::InfixOperation.new(
        '||',
        parent.table[:first_name], Arel::Nodes.build_quoted(' ')
      ),
      parent.table[:last_name]
    )
  end
  
  def unfollow(user)
    followerable_relationships.where(followable_id: user.id).destroy_all
  end


  before_create :randomize_id

  private

  def randomize_id
    begin
      self.id = SecureRandom.random_number(1_000_000_000)
    end while User.where(id: self.id).exists?
  end

  enum role: [:user, :admin]
  after_initialize :set_default_role, :if => :new_record?
  def set_default_role
    self.role ||= :admin
  end
  
end
