class Admin::UsersController < ApplicationController
  def index
    @users = User.where(role: 0)
  end

  def edit
    @user = User.find(params[:user_id])
    if request.env['PATH_INFO'] == "/admin/users/#{@user.id}/profile/edit"
      @profile_change = true
    else
      @profile_change = false
    end
  end

  def update
    @user = User.find(params[:user_id])
    if request.env['PATH_INFO'] == "/admin/users/#{@user.id}/profile"
      @user.update(user_params)
      if @user.save
        flash[:success] = "#{@user.name}'s' profile has been updated."
        redirect_to '/admin/users'
      else
        flash.now[:error] = @user.errors.full_messages.to_sentence
        @profile_change = true
        render :edit
      end
    else request.env['PATH_INFO'] == "/admin/users/#{@user.id}/password"
      @user.update(password_params)
      if @user.save
        flash[:success] = "#{@user.name}'s password has been updated."
        redirect_to '/admin/users'
      end
    end
  end

  private

    def user_params
      params.permit(:name, :address, :city, :state, :zip, :email, :password, :password_confirmation)
    end

    def password_params
      params.permit(:password, :password_confirmation)
    end
end
