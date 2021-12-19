require 'rails_helper'

RSpec.describe Bookmark, type: :model do
  before(:each) do
    @site = FactoryBot.create(:site)
    @bookmark = FactoryBot.create(:bookmark)
  end

  it 'title should be present' do
    @bookmark.title = nil
    expect(@bookmark).to_not be_valid
  end

  it 'url should be present' do
    @bookmark.url = nil
    expect(@bookmark).to_not be_valid
  end

  it 'url should be valid' do
    @bookmark.url = 'Hello World!'
    expect(@bookmark).to_not be_valid
  end

  it 'short url should be updated after update record' do
    @old_bookmark_short_url =  @bookmark.short_url
    @bookmark.update(url: 'https://www.pets.com/cats')
    expect(@bookmark.short_url).to_not eq(@old_bookmark_short_url)
  end
end
