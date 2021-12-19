require 'rails_helper'

RSpec.describe "Bookmarks", type: :request do

  describe "GET /bookmarks" do
    it 'returns 200 status and list of bookmarks when bookmarks found' do
      FactoryBot.create(:site)
      bookmark = FactoryBot.create(:bookmark)
      get bookmarks_path
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)).to eql({ "message" => "success", "data" => [bookmark.as_json] })
    end

    it 'returns 404 status and empty list of bookmarks when no bookmarks found' do
      get bookmarks_path
      expect(response).to have_http_status(404)
      expect(JSON.parse(response.body)).to eql({ "message" => "success", "data" => [] })
    end
  end

  describe "POST /bookmarks" do
    it 'returns 201 status , created bookmark and create site' do
      post bookmarks_path, :params => { "bookmark": { "url": "https://www.pets.com/dog", "title": "dogs at Pets" } }
      post bookmarks_path, :params => { "bookmark": { "url": "https://www.pets.com/cats", "title": "dogs at Pets" } }
      # new Site created
      expect(Site.count).to eq(1)

      expect(Bookmark.count).to eq(2)
      expect(response).to have_http_status(201)
    end

    it 'returns 201 status , created bookmark and find site' do
      FactoryBot.create(:site)
      # new Site created
      expect(Site.count).to eq(1)

      FactoryBot.create(:bookmark)

      post bookmarks_path, :params => { "bookmark": { "url": "https://www.google.com/dog", "title": "dogs at Google" } }

      # Site not created
      expect(Site.count).to eq(1)

      expect(Bookmark.count).to eq(2)
      expect(response).to have_http_status(201)
    end

    it 'returns 422 status if missing url or invalid url' do
      post bookmarks_path, :params => { "bookmark": { "title": "dogs at Pets" } }
      expect(Bookmark.count).to eq(0)
      expect(response).to have_http_status(422)
    end

    it 'returns 422 status if invalid url' do
      post bookmarks_path, :params => { "bookmark": { "url": "hello world!", "title": "dogs at Pets" } }
      expect(Bookmark.count).to eq(0)
      expect(response).to have_http_status(422)
    end

    it 'returns 422 status if missing title' do
      post bookmarks_path, :params => { "bookmark": { "url": "https://www.pets.com/dog" } }
      expect(Bookmark.count).to eq(0)
      expect(response).to have_http_status(422)
    end
  end

  describe "Show /bookmarks/:id" do
    it 'returns 200 status and bookmark record' do
      FactoryBot.create(:site)
      bookmark = FactoryBot.create(:bookmark)
      get bookmarks_path, :params => { id: bookmark.id }
      expect(Bookmark.count).to eq(1)
      expect(response).to have_http_status(200)
    end

    it 'returns 404 status no bookmark found' do
      get bookmarks_path, :params => { id: 1 }
      expect(Bookmark.count).to eq(0)
      expect(response).to have_http_status(404)
    end

  end

  describe "Update /bookmarks/:id" do
    it 'returns 202 status and update bookmark record' do

    end

    it 'returns 404 status if no bookmark found' do

    end

    it 'returns 400 status if title is missing' do

    end

    it 'returns 400 status if url is missing' do

    end

    it 'returns 400 status if url is invalid' do

    end
  end

  describe "Delete /bookmarks/:id" do
    # @TODO: @Mohie to investigate why not recognise "delete bookmarks_path, :params => {id: bookmark.id}"
    it 'returns 204 status' do
      FactoryBot.create(:site)
      bookmark = FactoryBot.create(:bookmark)
      expect(Bookmark.count).to eq(1)
      delete "/bookmarks/#{bookmark.id}"
      expect(Bookmark.count).to eq(0)
      expect(response).to have_http_status(204)
    end

    it 'returns 404 status if no bookmark found' do
      delete "/bookmarks/1"
      expect(Bookmark.count).to eq(0)
      expect(response).to have_http_status(404)
    end
  end

end
