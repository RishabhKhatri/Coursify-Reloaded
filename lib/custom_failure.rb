class CustomFailure < Devise::FailureApp
  def redirect_url
    get_started_url
  end

  # You need to override respond to eliminate recall
  def respond
    if http_auth?
      http_auth
    else
      store_location!
      flash[:danger] = "Invalid Email or Password" unless flash[:notice]
      redirect_to redirect_url
    end
  end
end