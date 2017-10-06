class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
	def facebook
		@user = User.from_omniauth(request.env["omniauth.auth"])

    if !@user.nil?
      sign_in_and_redirect @user #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to get_started_url
      flash[:danger] = "Please sign up with your Facebook email!"
    end
	end

  def google_oauth2
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if !@user.nil?
      sign_in_and_redirect @user #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Google") if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to get_started_url
      flash[:danger] = "Please sign up with your Goolge email!"
    end
  end

	def failure
		redirect_to root_path
	end
end