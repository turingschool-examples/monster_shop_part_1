class SessionsController < ApplicationController
  def new
    if session[:user_id]

  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      user_redirect(user)
      session[:user_id] = user.id
      flash[:happy] = "Welcome, #{user.name}!"
    else
      flash[:sad] = 'Credentials were incorrect'
      render :new
    end
  end

  private

  def user_redirect(user)
    if user.admin?
      redirect_to '/admin/dashboard'
    elsif user.merchant?
      redirect_to '/merchant/dashboard'
    else
      redirect_to '/profile'
   end
  end
end
