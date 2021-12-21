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

  describe "Show /bookmarks/:short_url_code/urls" do
    it 'returns 302 status and return original URL' do
      FactoryBot.create(:site)
      bookmark = FactoryBot.create(:bookmark)
      get "/bookmarks/#{bookmark.short_url}/urls"
      expect(Bookmark.count).to eq(1)
      # expect(JSON.parse(response.body)['data']['url']).to eq(bookmark.url)
      expect(response).to redirect_to(bookmark.url)
      expect(response).to have_http_status(302)
    end

    it 'returns 404 status no URL found' do
      get "/bookmarks/invalid_short_url/urls"
      expect(Bookmark.count).to eq(0)
      expect(response).to have_http_status(404)
    end

  end

  describe "Update /bookmarks/:id" do
    # @TODO: @Mohie to investigate why not recognise "put bookmarks_path, :params => {id: bookmark.id}"
    it 'returns 202 status and update bookmark record and create site' do
      FactoryBot.create(:site)
      bookmark = FactoryBot.create(:bookmark)
      put "/bookmarks/#{bookmark.id}", :params => { bookmark: {title: 'new title', url: 'https://www.pets.com/dogs'} }
      expect(Site.count).to eq(2)
      expect(Bookmark.count).to eq(1)
      expect(response).to have_http_status(202)
      expect(JSON.parse(response.body)['data']['url']).to_not eql(bookmark.url)
      expect(JSON.parse(response.body)['data']['title']).to_not eql(bookmark.url)
      expect(JSON.parse(response.body)['data']['site_id']).to_not eql(bookmark.site_id)
      expect(JSON.parse(response.body)['data']['short_url']).to_not eql(bookmark.short_url)
    end

    it 'returns 202 status and update bookmark record without creating site' do
      FactoryBot.create(:site)
      bookmark = FactoryBot.create(:bookmark)
      put "/bookmarks/#{bookmark.id}", :params => { bookmark: {title: 'new title', url: 'https://www.google.com/cats'} }
      expect(Site.count).to eq(1)
      expect(Bookmark.count).to eq(1)
      expect(response).to have_http_status(202)
      expect(JSON.parse(response.body)['data']['url']).to_not eql(bookmark.url)
      expect(JSON.parse(response.body)['data']['title']).to_not eql(bookmark.url)
      expect(JSON.parse(response.body)['data']['site_id']).to eql(bookmark.site_id)
      expect(JSON.parse(response.body)['data']['short_url']).to_not eql(bookmark.short_url)
    end

    it 'returns 404 status if no bookmark found' do
      put "/bookmarks/5", :params => { bookmark: {title: 'new title', url: 'https://www.google.com/cats'} }
      expect(Site.count).to eq(0)
      expect(Bookmark.count).to eq(0)
      expect(response).to have_http_status(404)
    end

    it 'returns 400 status if title is missing' do
      FactoryBot.create(:site)
      bookmark = FactoryBot.create(:bookmark)
      put "/bookmarks/#{bookmark.id}", :params => { bookmark: { url: 'https://www.google.com/cats'} }
      expect(Site.count).to eq(1)
      expect(Bookmark.count).to eq(1)
      expect(response).to have_http_status(400)
    end

    it 'returns 400 status if url is missing' do
      FactoryBot.create(:site)
      bookmark = FactoryBot.create(:bookmark)
      put "/bookmarks/#{bookmark.id}", :params => { bookmark: { title: 'new title' } }
      expect(Site.count).to eq(1)
      expect(Bookmark.count).to eq(1)
      expect(response).to have_http_status(400)
    end

    it 'returns 400 status if url is invalid' do
      FactoryBot.create(:site)
      bookmark = FactoryBot.create(:bookmark)
      put "/bookmarks/#{bookmark.id}", :params => { bookmark: { url: 'Hello World'} }
      expect(Site.count).to eq(1)
      expect(Bookmark.count).to eq(1)
      expect(response).to have_http_status(400)
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
