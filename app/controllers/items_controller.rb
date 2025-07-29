# app/controllers/items_controller.rb

class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @items = Item.includes(:user).order(created_at: :desc)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def item_params
    params.require(:item).permit(
      :image, :name, :info, :category_id, :condition_id,
      :shipping_fee_id, :prefecture_id, :shipping_day_id, :price
    ).merge(user_id: current_user.id)
  end
end
