class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :cart, :current_user, :user_redirect

  unless Rails.application.config.consider_all_requests_local
    rescue_from ActionController::RoutingError, with: -> { render_404  }
  end

  def render_404
    respond_to do |format|
      format.html { render template: 'errors/404', status: 404 }
      format.all { render nothing: true, status: 404 }
    end
  end

  def cart
    @cart ||= Cart.new(session[:cart] ||= Hash.new(0))
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

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
