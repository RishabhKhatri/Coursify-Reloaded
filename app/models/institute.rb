class Institute < ApplicationRecord
	resourcify
	mount_uploader :profile, PictureUploader
	mount_uploader :background, PictureUploader
	before_create :generate_invitation

	PHONE_REGEX = /\A(?:(?:\+|0{0,2})91(\s*[\ -]\s*)?|[0]?)?[789]\d{9}|(\d[ -]?){10}\d\z/
	EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :name, presence: true, length: { maximum: 100 }
	validates :contact, presence: true, uniqueness: true, format: { with: PHONE_REGEX }
	validates :email, presence: true, uniqueness: true, format: { with: EMAIL_REGEX }
	validates :slug, presence: true, uniqueness: true, length: { maximum: 6, minimum: 3 }
	validates :website, presence: true
	validates :about, presence: true, length: { maximum: 500 }
	validate :picture_size

	private

	def picture_size
		if self.profile.size > 5.megabytes
			errors.add(:profile, "should be less than 5MB")
		end
		if self.background.size > 5.megabytes
			errors.add(:background, "should be less than 5MB")
		end
	end

	def generate_invitation
		self.invitation_code = self.slug + (0...8).map { (65 + rand(26)).chr }.join
	end
end
