require 'uri'

class Site < ApplicationRecord
  has_many :bookmarks, dependent: :destroy

  def self.extract_site_name(url)
    URI.parse(url).host
  end

end
