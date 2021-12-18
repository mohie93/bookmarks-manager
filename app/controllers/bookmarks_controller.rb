class BookmarksController < ApplicationController
  def index
    bookmarks = Bookmark.all
    render json: { message: :success, data: bookmarks }, status: :ok
  end
end
