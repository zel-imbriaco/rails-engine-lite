require 'rails_helper'

RSpec.describe 'Items', type: :request do

  describe 'PUT /api/v1/items/:id' do
    before do
      @item = create(:item, id: 10, name: "Zel's Bells")
      put "/api/v1/items/10", params: { description: "New and Improved, Tinnitus guaranteed!!" }
    end

    it 'Returns a successful status code' do
      expect(response).to have_http_status :success
    end

    it 'Updates the requested item' do
      expect(json["data"]["type"]).to eq "item"
      expect(json["data"]["id"]).to eq "10"
      expect(json["data"]["attributes"]["name"]).to eq "Zel's Bells"
      expect(json["data"]["attributes"]["description"]).to eq "New and Improved, Tinnitus guaranteed!!"
    end
  end
end