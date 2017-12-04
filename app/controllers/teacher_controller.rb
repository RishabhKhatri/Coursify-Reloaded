class TeacherController < ApplicationController

	before_action :authenticate_user!

  def show
    @picture_url = current_user.picture.url
  end

  def index
  end

  def remove_picture
  	if current_user.picture?
  		current_user.remove_picture!
  		current_user.save
  		redirect_to teacher_show_url
  		flash[:success] = "Profile picture removed successfully."
  	else
  		redirect_to teacher_show_url
  		flash[:danger] = "Remove picture failed!"
  	end
  end
end
