require 'rails_helper'

RSpec.describe 'Items', type: :request do

  describe "GET /items/find_all" do
    before do
      @item1 = create(:item, name: "Zel's Bells", unit_price: 5.00)
      @item2 = create(:item, name: "Bell's Zels", unit_price: 10.00)
      @item3 = create(:item, name: "Grellakin", unit_price: 15.00)
      @item4 = create(:item, name: "ElLatte", unit_price: 2.50)
    end

    it 'Returns 200 code on success' do
      get "/api/v1/items/find_all", params: { name: "z"}
      expect(response).to have_http_status :success
    end 

    it 'Finds items by name' do
      get "/api/v1/items/find_all", params: { name: "zel" }
      expect(json["data"].count).to eq 2
      expect(json["data"].first["attributes"]["name"]).to eq "Zel's Bells"
      expect(json["data"].last["attributes"]["name"]).to eq "Bell's Zels"
    end

    it "Finds items by minimum price" do
      get "/api/v1/items/find_all", params: { min_price: 10.00 }
      expect(json["data"].count).to eq 2
      expect(json["data"].first["attributes"]["name"]).to eq "Bell's Zels"
      expect(json["data"].last["attributes"]["name"]).to eq "Grellakin"
    end

    it "Finds items by maximum price" do
      get "/api/v1/items/find_all", params: { max_price: 9.99 }
      expect(json["data"].count).to eq 2
      expect(json["data"].first["attributes"]["name"]).to eq "Zel's Bells"
      expect(json["data"].last["attributes"]["name"]).to eq "ElLatte"
    end

    it "Finds items by min & max price" do
      get "/api/v1/items/find_all", params: { min_price: 2.50, max_price: 4.99 }
      expect(json["data"].count).to eq 1
      expect(json["data"].first["attributes"]["name"]).to eq "ElLatte"
    end

    it "Returns an error if using invalid parameter combos" do
      get "/api/v1/items/find_all", params: { min_price: 2.50, name: "el" }
      expect(response).to have_http_status 400
      get "/api/v1/items/find_all", params: { max_price: 6.49, name: "zel" }
      expect(response).to have_http_status 400
      get "/api/v1/items/find_all", params: { min_price: 14.50, max_price: 17.50, name: "el" }
      expect(response).to have_http_status 400
    end
  end
end