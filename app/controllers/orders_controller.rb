class OrdersController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :set_order, only: [:index, :create]
  def index
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      @order_address.save
      redirect_to root_path
    else
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
end
