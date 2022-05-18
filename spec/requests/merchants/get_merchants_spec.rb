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

    it 'returns 200 status code' do
      expect(response).to have_http_status :success
    end
  end

  describe 'GET /merchants/:id' do
    before do
      FactoryBot.create_list(:merchant, 10)
    end

    it 'Returns 200 status on valid request' do
      get "/api/v1/merchants/1"
      expect(response).to have_http_status :success
    end

    it 'Returns 404 status on invalid merchant id' do
      get "/api/v1/merchants/413"
      binding.pry
      expect(response).to have_http_status :failure
    end
  end
end