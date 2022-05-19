class Api::V1::ItemsController < ApplicationController

  def index
      render json: ItemSerializer.new(Item.all)
  end

  def show
    if Item.exists?(params[:id])
      render json: ItemSerializer.new(Item.find(params[:id]))
    else
      render status: 404
    end
  end

  def create
    new_item = Item.create!(item_params)
    render status: 201, json: ItemSerializer.new(Item.find(new_item.id))
  end

  def destroy
    Item.destroy(params[:id])
  end

  def update
    if Item.exists?(params[:id])
      Item.update(item_params)
      render json: ItemSerializer.new(Item.find(params[:id]))
    else
      render status: 404
    end
  end

  def merchant
    if Item.exists?(params[:id])
      render json: MerchantSerializer.new(Merchant.find(Item.find(params[:id]).merchant_id))
    else
      render status: 404
    end
  end

  private
    def item_params
      params.permit(:name, :description, :unit_price, :merchant_id)
    end
end