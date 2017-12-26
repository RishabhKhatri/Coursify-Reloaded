class User < ApplicationRecord
  rolify
  after_create :assign_default_role
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :lockable, 
         :omniauthable, :omniauth_providers => [:facebook, :google_oauth2]

  validate :picture_size
  mount_uploader :picture, PictureUploader

  def self.from_omniauth(auth)
		email = auth['info']['email']
		User.find_by(email: email)
	end

  def to_liquid
    return UserDrop.new(self)
  end

  def assign_default_role
    self.add_role(:student) if self.roles.blank?
  end

	protected

		def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end
end
