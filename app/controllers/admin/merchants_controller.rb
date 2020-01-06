class Admin::MerchantsController < Admin::BaseController

  def index
    @path = '/admin/'
    @merchants = Merchant.all
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
  end

  def update
    merchant = Merchant.find(params[:id])
    if params[:status] == 'deactivate'
      merchant.update(active?: false)
      merchant.items.update(active?: false)
      flash[:happy] = 'Merchant Deactivated'
      redirect_back fallback_location: '/admin/merchants'
    else
      merchant.update(active?: true)
      merchant.items.update(active?: true)
      flash[:happy] = 'Merchant Activated'
      redirect_back fallback_location: '/admin/merchants'
    end
  end

end
