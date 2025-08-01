# app/controllers/items_controller.rb

class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :redirect_unless_owner, only: [:edit, :update, :destroy]
  before_action :redirect_if_sold_out, only: [:edit, :update]
  
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

  def show
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit
    end
  end

  def destroy
    if current_user.id == @item.user_id
      @item.destroy
      redirect_to root_path
    else
      redirect_to root_path
    end
  end


  private

  def set_item
    @item = Item.find(params[:id])
  end

  def redirect_unless_owner
    redirect_to root_path unless current_user.id == @item.user_id
  end

  def redirect_if_sold_out
    if @item.order.present? || current_user.id != @item.user_id
      redirect_to root_path
    end
  end

  def item_params
    params.require(:item).permit(
      :image, :name, :info, :category_id, :condition_id,
      :shipping_fee_id, :prefecture_id, :shipping_day_id, :price
    ).merge(user_id: current_user.id)
  end
end
