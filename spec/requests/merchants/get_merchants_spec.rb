require 'rails_helper'

RSpec.describe 'Merchants', type: :request do

  describe 'GET /merchants' do
    before do
      FactoryBot.create_list(:merchant, 10)
      get "/api/v1/merchants"
    end

    it 'returns all merchants' do
      expect(json["data"].size).to eq 10 
    end

    it 'Has expected attributes for merchants' do
      expect(json["data"].first["type"]).to eq "merchant"
      expect(json["data"].last["type"]).to eq "merchant"
      expect(json["data"].first["attributes"]).to have_key("name")
      expect(json["data"].last["attributes"]).to have_key("name")
    end

    it 'returns 200 status code' do
      expect(response).to have_http_status :success
    end
  end

  describe 'GET /merchants/:id' do
    before do
      FactoryBot.create_list(:merchant, 10)
      @merchant1 = create(:merchant, id: 1, name: "Zel")
      get "/api/v1/merchants/1"
    end

    it 'Returns 200 status on valid request' do
      expect(response).to have_http_status :success
    end

    it 'Returns merchant data' do
      expect(json["data"]["type"]).to eq "merchant"
      expect(json["data"]["attributes"]).to have_key "name"
      expect(json["data"]["attributes"]["name"]).to eq "Zel"
    end
    
    it 'Returns 404 status on invalid merchant' do
      get '/api/v1/merchants/8923987297'
      expect(response).to have_http_status 404
    end
  end

  describe 'GET /merchants/:id/items' do
    before do
      @merchant1 = create(:merchant, id: "1", name: "Zel")
      @merchant2 = create(:merchant, id: "2")
      @item1 = create(:item, id: "25", merchant_id: 1)
      @item2 = create(:item, id: "42", merchant_id: 1)
      @item3 = create(:item, id: "77", merchant_id: 2)
      @item4 = create(:item, id: "50", merchant_id: 1)

      get "/api/v1/merchants/1/items"
    end

    it 'Returns 200 status on valid request' do
      expect(response).to have_http_status :success
    end

    it 'Returns items for chosen merchant' do
      expect(json["data"].count).to eq 3
      expect(json["data"].first["type"]).to eq "item"
      expect(json["data"].last["type"]).to eq "item"
      expect(json["data"][1]["type"]).to eq "item"
      expect(json["data"].first["id"]).to eq "25"
      expect(json["data"].last["id"]).to eq "50"
      expect(json["data"][1]["id"]).to  eq "42"
    end

    it 'Returns 404 for invalid merchant' do
      get '/api/v1/merchants/8923987297/items'
      expect(response).to have_http_status 404
    end
  end
end