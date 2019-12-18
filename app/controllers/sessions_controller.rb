class SessionsController < ApplicationController
  def new
    redirect_to '/profile' if session[:user_id]
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
       if user.admin?
         redirect_to '/admin/dashboard'
       elsif user.merchant?
         redirect_to '/merchant/dashboard'
       else
         redirect_to '/profile'
      end
      flash[:happy] = "Welcome, #{user.name}!"
    else
      flash[:sad] = 'Credentials were incorrect'
      render :new
    end
  end


end
