class User < ApplicationRecord
  rolify
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :lockable, 
         :omniauthable, :omniauth_providers => [:facebook, :google_oauth2]

  validate :picture_size
  PHONE_REGEX = /\A(?:(?:\+|0{0,2})91(\s*[\ -]\s*)?|[0]?)?[789]\d{9}|(\d[ -]?){10}\d\z/
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name, presence: true, length: { maximum: 50 }
  validates :contact, presence: true, uniqueness: true, format: { with: PHONE_REGEX }
  validates :email, presence: true, uniqueness: true, format: { with: EMAIL_REGEX }
  validates :dob, presence: true
  validate :age_limit
  mount_uploader :picture, PictureUploader

  def self.from_omniauth(auth)
		email = auth['info']['email']
		User.find_by(email: email)
	end

  def to_liquid
    return UserDrop.new(self)
  end

	protected

		def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end

    def age_limit
      if dob > 18.years.ago
        errors.add(:dob, "You should be over 18 years old.")
      end
    end
end
