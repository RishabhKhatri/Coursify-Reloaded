class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

	protected

	def configure_permitted_parameters
	  devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
	  devise_parameter_sanitizer.permit(:account_update, keys: [:name])

	  devise_parameter_sanitizer.permit(:sign_up, keys: [:contact])
	  devise_parameter_sanitizer.permit(:account_update, keys: [:contact])

	  devise_parameter_sanitizer.permit(:sign_up, keys: [:expertise])
	  devise_parameter_sanitizer.permit(:account_update, keys: [:expertise])

	  devise_parameter_sanitizer.permit(:sign_up, keys: [:picture])
	  devise_parameter_sanitizer.permit(:account_update, keys: [:picture])

	  devise_parameter_sanitizer.permit(:sign_up, keys: [:admin])
	  devise_parameter_sanitizer.permit(:account_update, keys: [:admin])

	  devise_parameter_sanitizer.permit(:sign_up, keys: [:imglink])
	  devise_parameter_sanitizer.permit(:account_update, keys: [:imglink])

	  devise_parameter_sanitizer.permit(:sign_up, keys: [:dob])
	  devise_parameter_sanitizer.permit(:account_update, keys: [:dob])

	  devise_parameter_sanitizer.permit(:sign_up, keys: [:account_type])
	  devise_parameter_sanitizer.permit(:account_update, keys: [:account_type])	  
	end

	def after_sign_in_path_for(resource)
		edit_user_registration_path(resource)
	end
end
