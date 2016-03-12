class Admin::UsersController < Admin::AdminsController
  before_action :authenticate_user!
  expose(:user, attributes: :user_params)

  def index
  end

  def show
    @user = User.find_by(email: params[:email].strip)
  end

  def destroy
    user.destroy
    redirect_to admin_users_path
  end

  def edit
  end

  def update
     if user.save
      redirect_to admin_show_path(email: user.email)
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name)
  end
end
