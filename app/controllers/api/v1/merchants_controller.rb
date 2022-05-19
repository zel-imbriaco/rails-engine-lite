class Api::V1::MerchantsController < ApplicationController

  def index
    render json: MerchantSerializer.new(Merchant.all)
  end 

  def show
    if Merchant.exists?(params[:id])
      render json: MerchantSerializer.new(Merchant.find(params[:id]))
    else
      render status: 404
    end
  end

  def items
    if Merchant.exists?(params[:id])
      render json: ItemSerializer.new(Item.where("merchant_id = ?", params[:id]))
    else
      render status: 404
    end
  end
end