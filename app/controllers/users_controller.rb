class UsersController < ApplicationController
	before_action :authenticate_user!
	before_action :check_teacher

  def show
  end

  def manage_institutes
  	@super_admins = Institute.with_role(:super_admin, current_user)
  	@admins = Institute.with_role(:admin, current_user)
  	@teachers = Institute.with_role(:teacher, current_user)
  end

  private

  def check_teacher
  	if !current_user.has_role?(:teacher)
  		flash[:danger] = "Not authorized!"
  		redirect_to root_url(subdomain: '')
  	end
  end
end
