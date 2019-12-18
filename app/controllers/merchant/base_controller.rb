class Merchant::BaseController < ApplicationController
  before_action :require_merchant

  def require_merchant
    render '/errors/404' unless current_user && current_user.merchant?
  end
end
