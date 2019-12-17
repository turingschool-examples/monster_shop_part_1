class SessionsController < ApplicationController
  def new
  end

  def create
    if (user = User.find_by(email: params[:email])) && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Hello, #{user.name}. You are now logged in."
      redirect_to '/profile'
    else
      flash[:error] = "Login credentials are incorrect. Please try again."
      render :new
    end
  end
end
