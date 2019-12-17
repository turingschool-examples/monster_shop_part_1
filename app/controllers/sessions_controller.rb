class SessionsController < ApplicationController
  def new

  end

  def create
    user = User.find_by(email: params[:email])

    if user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to '/profile'
      flash[:happy] = "Welcome, #{user.name}!"
    else
      flash[:sad] = 'Credentials were incorrect'
      render :new
    end
  end

  
end
