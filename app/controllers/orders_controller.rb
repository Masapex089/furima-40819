class OrdersController < ApplicationController
  before_action :authenticate_user!, only: :index
  before_action :set_order, only: [:index, :create]
  before_action :move_to_index, only: :index
  def index
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      pay_item
      @order_address.save
      redirect_to root_path
    else
      gon.public_key = ENV['PAYJP_PUBLIC_KEY']
      render 'index', status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:order_address).permit(:post_code, :prefecture_id, :city, :block, :building_name, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token]) # rubocop:disable Layout/LineLength
  end

  def set_order
    @order = Item.find(params[:item_id])
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @order.price,
      card: order_params[:token],
      currency: 'jpy'
    )
  end

  def move_to_index
    redirect_to root_path if current_user.id == @order.user_id
  end
end
