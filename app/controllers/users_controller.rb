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

  def join_institute
    if (params.has_key?(:join_code))
      code = params[:join_code]
      @institute = Institute.find_by_invitation_code(code)
      if @institute.present?
        if current_user.has_role? :super_admin, @institute
          flash[:info] = "You are already a super admin!"
          redirect_to root_url(subdomain: '')
        else
          current_user.add_role :teacher, @institute
          redirect_to root_url(subdomain: @institute.slug)
        end
      else
        flash[:danger] = "Invalid invitation code!"
        redirect_to root_url(subdomain: '')
      end
    else
      flash[:danger] = "Invalid invitation code!"
      redirect_to root_url(subdomain: '')
    end
  end

  private

  def check_teacher
  	if !current_user.has_role?(:teacher)
  		flash[:danger] = "Not authorized!"
  		redirect_to root_url(subdomain: '')
  	end
  end
end
