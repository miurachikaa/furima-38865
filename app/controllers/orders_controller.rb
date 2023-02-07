class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  before_action :prevent_url, only: [:index]

  def index
    @order_information = OrderInformation.new
    @item = Item.find(params[:item_id])
    return unless @item.order.present?

    redirect_to root_path
  end

  def create
    @order_information = OrderInformation.new(order_params)
    @item = Item.find(params[:item_id])
    if @order_information.valid?
      pay_item
      @order_information.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def order_params
    params.require(:order_information).permit(:postal_code, :item_prefecture_id, :city, :addresses, :building, :phone_number).merge(
      user_id: current_user.id, item_id: params[:item_id], token: params[:token]
    )
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.item_price,
      card: order_params[:token],
      currency: 'jpy'
    )
  end

  def prevent_url
    @item = Item.find(params[:item_id])
    return unless @item.user_id == current_user.id || !@item.order.nil?

    redirect_to root_path
  end
end
