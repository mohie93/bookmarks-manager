class SitesController < ApplicationController
  def index
    begin
      sites = Site.all
      render json: { message: :success, data: sites }, status: :ok
    rescue NotFoundError => error
      render json: { message: :success, data: [], error: error }, status: :not_found
    end
  end
end
