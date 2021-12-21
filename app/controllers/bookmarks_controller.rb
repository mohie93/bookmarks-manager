class BookmarksController < ApplicationController
  before_action :find_bookmark, only: [:show, :update, :delete]

  def index
    begin
      bookmarks = Bookmark.all
      render json: { message: :success, data: bookmarks }, status: (bookmarks.empty? ? :not_found : :ok)
    rescue NotFoundError => error
      render json: { message: :success, data: [], error: error }, status: :not_found
    end
  end

  def create
    begin
      @bookmark = Bookmark.new(bookmark_params)
      find_or_create_site_then_shrink_url
      if @bookmark.save
        render json: { message: :success, data: @bookmark }, status: :created
      else
        render json: { message: :failed, error: @bookmark.errors }, status: :unprocessable_entity
      end
    rescue StandardError => error
      render json: { message: :bad_request, data: {}, error: error }, status: :unprocessable_entity
    end
  end

  def find_by_short_url_code
    @bookmark = Bookmark.find_by(short_url: params[:short_url_code])
    if @bookmark.present?
      redirect_to @bookmark.url
    else
      render json: { message: :not_found, data: @bookmark }, status: :not_found
    end
  end

  def show
    render json: { message: :success, data: @bookmark }, status: :ok
  end

  def update
    begin
      @bookmark.url = bookmark_params['url']
      @bookmark.title = bookmark_params['title']
      find_or_create_site_then_shrink_url
      if @bookmark.save
        render json: { message: :success, data: @bookmark }, status: :accepted
      else
        render json: { message: :not_found, data: @bookmark.errors }, status: :bad_request
      end
    rescue StandardError => error
      render json: { message: :bad_request, data: {}, error: error }, status: :bad_request
    end
  end

  def delete
    @bookmark.destroy
    render json: { message: :success, data: @bookmark }, status: :no_content
  end

  private

  def find_bookmark
    begin
      @bookmark = Bookmark.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { message: :not_found, data: @bookmark }, status: :not_found
    end
  end

  def find_or_create_site_then_shrink_url
    @site = Site.find_or_create_by(address: Site.extract_site_name(@bookmark.url))
    @bookmark.site_id = @site.id
    @bookmark.shorten_url
  end

  def bookmark_params
    params.require(:bookmark).permit(:url, :title)
  end
end
