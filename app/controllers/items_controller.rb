class ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def new
    @item = Item.new
  end

  def create
  end

  private

  def item_params
    params.require(:item).permit(:name, :explanation, :price, :category_id, :item_status_id, :delivery_fee_id, :prefecture_id, :delivery_day_id).merge(user_id: current_user.id) # rubocop:disable Layout/LineLength
  end
end
