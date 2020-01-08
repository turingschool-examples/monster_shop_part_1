class Admin::UsersController < Admin::BaseController
  def index
    @users = User.all.order(:role, :name)
  end

  def show
    @user = User.find(params[:id])
  end
end
