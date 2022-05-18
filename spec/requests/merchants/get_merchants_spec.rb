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
      @merchant1 = Merchant.create!(id: 1, name: "Zel")
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
  end
end