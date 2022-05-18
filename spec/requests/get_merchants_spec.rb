require 'rails_helper'

RSpec.describe 'Merchants', type: :request do

  describe 'GET /index' do
    before do
      FactoryBot.create_list(:merchant, 10)
      get "/api/v1/merchants"
    end

    it 'returns all merchants' do
      expect(json.size).to eq 10
    end

    it 'returns 200 status code' do
      expect(response).to have_http_status :success
    end
  end
end