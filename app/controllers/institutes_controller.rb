class InstitutesController < ApplicationController
	before_action :authenticate_user!
	before_action :check_teacher, only: [:new, :create]
  before_action :check_super_admin, only: [:edit, :update]

  def new
  end

  def create
  	@institute = Institute.new(institute_params)
  	if @institute.save
  		flash[:success] = "Institute created successfully."
  		current_user.add_role :super_admin, @institute
  		redirect_to root_url(subdomain: @institute.slug)
  	else
  		render 'new'
  	end
  end

  def edit
    @institute = Institute.find_by_slug!(request.subdomain)
  end

  def update
    @institute = Institute.find_by_slug!(request.subdomain)
    if @institute.update_attributes(institute_params)
      flash[:success] = "Institute profile updated successfully."
      redirect_to root_url(subdomain: @institute.slug)
    else
      render 'edit'
    end
  end

  def show
  	@institute = Institute.find_by_slug!(request.subdomain)
  end

  def index
  end

  private

  def check_teacher
  	if !current_user.has_role?(:teacher)
  		flash[:danger] = "Not authorized!"
  		redirect_to root_url(subdomain: '')
  	end
  end

  def check_super_admin
    current_institute = Institute.find_by_slug!(request.subdomain)
    if !current_user.has_role?(:super_admin, current_institute)
      flash[:danger] = "Not authorized!"
      redirect_to root_url(subdomain: '')
    end
  end

  def institute_params
  	params.require(:institute).permit(:name, :slug, :profile, :background, :contact, :email, :about, :website)
  end
end
