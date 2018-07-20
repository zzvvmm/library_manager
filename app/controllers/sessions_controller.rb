class SessionsController < ApplicationController
  def new
    if current_user
      if current_user.admin?
        redirect_to users_path
      else
        redirect_to books_path
      end
    end
  end

  def create
    user = User.find_by email: sess[:email].downcase
    if user&.authenticate(sess[:password])
      log_in user
      sess[:remember_me] == "1" ? remember(user) : forget(user)
      redirect_back_or user
    else
      flash.now[:danger] = t "flash_invalid"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private
  def sess
    params[:session]
  end
end
