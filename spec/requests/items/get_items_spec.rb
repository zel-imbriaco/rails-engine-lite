require 'rails_helper'

RSpec.describe 'Items', type: :request do

  describe 'GET /items' do
    before do
      FactoryBot.create_list(:item, 10)
      get '/api/v1/items'
    end

    it 'Returns 200 response' do
      expect(response).to have_http_status :success
    end

    it 'Returns all Items' do
      expect(json["data"].count).to eq 10
    end

    it 'has all expected attributes for merchants' do
      expect(json["data"].first["attributes"]).to have_key "name"
      expect(json["data"].first["attributes"]).to have_key "description"
      expect(json["data"].first["attributes"]).to have_key "unit_price"
      expect(json["data"].first["type"]).to eq "item"
      expect(json["data"].last["attributes"]).to have_key "name"
      expect(json["data"].last["attributes"]).to have_key "description"
      expect(json["data"].last["attributes"]).to have_key "unit_price"
      expect(json["data"].last["type"]).to eq "item"
    end
  end

  describe 'GET /items/:id' do
    before do
      @item = create(:item, id: 10)
      get '/api/v1/items/10'
    end

    it 'Returns 200 response' do
      expect(response).to have_http_status :success
    end

    it 'Returns the item' do
      expect(json["data"]["attributes"]).to have_key "name"
      expect(json["data"]["attributes"]).to have_key "description"
      expect(json["data"]["attributes"]).to have_key "unit_price"
      expect(json["data"]["type"]).to eq "item"
      expect(json["data"]["id"]).to eq "10"
    end
  end
end