class Admin::BaseController < ApplicationController
  before_action :require_admin

  def require_admin
    render '/errors/404' unless current_user && current_user.admin?
  end


end
