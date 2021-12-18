require 'rails_helper'

RSpec.describe "Bookmarks", type: :request do
  describe "GET /bookmarks" do
    it 'returns 200 status and list of bookmarks when bookmarks found' do

    end

    it 'returns 404 status and empty list of bookmarks when no bookmarks found' do

    end
  end

  describe "POST /bookmarks" do
    it 'returns 201 status , created bookmark and create or get site' do

    end

    it 'returns 422 status if missing url' do

    end

    it 'returns 422 status if invalid url' do

    end

    it 'returns 422 status if missing title' do

    end
  end

  describe "Show /bookmarks/:id" do
    it 'returns 200 status and bookmark record' do

    end

    it 'returns 404 status no bookmark found' do

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
    it 'returns 204 status' do

    end

    it 'returns 404 status if no bookmark found' do

    end
  end
end
