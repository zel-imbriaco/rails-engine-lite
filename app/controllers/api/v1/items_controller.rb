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

  def merchant
    if Item.exists?(params[:id])
      render json: MerchantSerializer.new(Merchant.find(Item.find(params[:id]).merchant_id))
    else
      render status: 404
    end
  end
end