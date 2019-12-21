class Merchant::MerchantController < Merchant::BaseController
  def show
    @user = current_user
  end
end
