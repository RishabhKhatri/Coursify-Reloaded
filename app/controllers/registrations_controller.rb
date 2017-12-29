class RegistrationsController < Devise::RegistrationsController

  def new_teacher
    build_resource
    yield resource if block_given?
    respond_with resource
  end

  def create
  	build_resource(sign_up_params)
    resource.save
    yield resource if block_given?
    if resource.persisted?
      resource.add_role(:student)
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      render 'static/get_started'
		end
  end

  def create_teacher
    build_resource(sign_up_params)
    resource.save
    yield resource if block_given?
    if resource.persisted?
      resource.add_role(:teacher)
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      render 'new_teacher'
    end
  end

  def destroy
    resource.destroy
    Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
    set_flash_message! :notice, :destroyed
    yield resource if block_given?
    respond_with_navigational(resource){ redirect_to root_url(subdomain: '') }
  end

  protected

  def after_update_path_for(resource)
    profile_path
  end
end
