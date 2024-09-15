class OrdersController < ApplicationController
  def index
    @order = Order.new(order_params)
  end

  def create
    @order = Order.new(order_params)
    if @order.valid?
      @order.save
      redirect_to root_path
    else
      render 'index', status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:order).permit(:name, :explanation, :price, :image, :category_id, :item_status_id, :delivery_fee_id, :prefecture_id, :delivery_day_id).merge(user_id: current_user.id) # rubocop:disable Layout/LineLength
  end
end
