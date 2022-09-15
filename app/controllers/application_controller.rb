class ApplicationController < ActionController::Base
  include SessionsHelper
  
  private
  def logged_in_user
    unless logged_in?
      flash[:danger] = "Please login"
      redirect_to login_url
    end
  end

  def load_user
    @user = User.find_by id: params[:id]
  end

  def admin_user
    unless current_user.is_admin?
      flash[:danger] = "Admin"
      redirect_to root_url
    end
  end

  def correct_user
    @user = User.find_by id: params[:id]
    redirect_to root_url unless current_user.is_user? @user
  end
end
