class Admin::UsersController < Admin::BaseController
  before_action :load_user, only: :destroy
  
  def index
    @users = User.order(created_at: :desc).paginate page: params[:page]
  end
  
  def destroy
    if @user.destroy
      flash[:success] = "Delete success"
    else
      flash[:danger] = "Something Wrong!!!"
    end
    redirect_to admin_users_url
  end
  
  private
  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end
  
  def load_user
    @user = User.find_by id: params[:id]
  end
end
