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

  def find_all
    if params[:name] && params[:min_price] || params[:name] && params[:max_price] || params[:name] && params[:min_price] && params[:max_price] || !params[:name] && !params[:min_price] && !params[:max_price]
      render status: 400
    else
      if params[:name]
        render json: ItemSerializer.new(Item.where("name ILIKE ?", "%#{params[:name]}%"))
      elsif params[:min_price] && params[:max_price]
        render json: ItemSerializer.new(Item.where("unit_price BETWEEN ? AND ?", params[:min_price], params[:max_price]))
      elsif params[:min_price]
        render json: ItemSerializer.new(Item.where("unit_price >= ?", params[:min_price]))
      else
        render json: ItemSerializer.new(Item.where("unit_price <= ?", params[:max_price]))
      end
    end
  end

  private
    def item_params
      params.permit(:name, :description, :unit_price, :merchant_id)
    end
end