class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new]
  def index
    @items = Item.order('created_at DESC') # 商品一覧機能実装の際に実装するもの
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :explanation, :price, :image, :category_id, :item_status_id, :delivery_fee_id, :prefecture_id, :delivery_day_id).merge(user_id: current_user.id) # rubocop:disable Layout/LineLength
  end
end
