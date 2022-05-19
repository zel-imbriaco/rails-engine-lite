require 'rails_helper'

RSpec.describe 'Items', type: :request do

  describe 'DELETE /items/:id' do
    before do
      @item1 = create(:item, id: 10, name: "Zel's Bells")
      @item2 = create(:item, id: 11, name: "Bell's Zels")
      delete '/api/v1/items/10'
    end

    it 'Returns success code when successful' do
      expect(response).to have_http_status 204
    end

    it 'Successfully deletes specified item' do
      get '/api/v1/items'
      expect(json["data"].count).to eq 1
    end
  end
end