require 'rails_helper'

RSpec.describe 'Merchants', type: :request do

  describe 'GET /merchants/find' do
    before do
      @merchant1 = create(:merchant, name: "Zel")
      @merchant2 = create(:merchant, name: "Mel")
      @merchant3 = create(:merchant, name: "Noah")
      @merchant4 = create(:merchant, name: "Ellah")
    end

    it "Returns success http response when successful" do
      get "/api/v1/merchants/find", params: { name: "Zel" }
      expect(response).to have_http_status :success
    end

    it "Returns all matching names" do
      get "/api/v1/merchants/find", params: { name: "El" }
      expect(json["data"].count).to eq 3
      expect(json["data"].first["attributes"]["name"]).to eq "Zel"
      expect(json["data"].last["attributes"]["name"]).to eq "Ellah"
    end

    it "Returns a 400 error if name field is not filled" do
      get "/api/v1/merchants/find"
      expect(response).to have_http_status 400
    end
  end
end