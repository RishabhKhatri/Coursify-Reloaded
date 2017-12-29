module ApplicationHelper
	def institute
		@institute ||= Institute.new
	end

	def institute_name
		:institute
	end
	
	def resource_name
		:user
	end

	def resource
		@resource ||= User.new
	end

	def devise_mapping
		@devise_mapping ||= Devise.mappings[:user]
	end
end
