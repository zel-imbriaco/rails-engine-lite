require 'rails_helper'

RSpec.describe 'Items', type: :request do

  describe 'POST /items' do
    before do
      @merchant1 = create(:merchant, id: 1, name: "Zel")
      post "/api/v1/items", params: { name: "Zel's Bells", description: "Lorem Ipsum", unit_price: 499.99, merchant_id: 1 }
    end

    it "Returns a 201 status on successful POST" do
      expect(response).to have_http_status :success
    end

    it "Successfully creates upon post method completion" do
      expect(json["data"].count).to eq 3
      expect(json["data"]["type"]).to eq "item"
      expect(json["data"]["attributes"].count).to eq 4
      expect(json["data"]["attributes"]["name"]).to eq "Zel's Bells"
    end
  end
end
