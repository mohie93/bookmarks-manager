class BookmarkUrlValidator < ActiveModel::Validator
  def validate(record)
    url_valid = record.url.present? && record.url.match('^(http|https):\/\/|[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,6}(:[0-9]{1,5})?(\/.*)?$/ix')
    record.errors.add :base, "Invalid URL" unless url_valid
  end
end

class Bookmark < ApplicationRecord
  belongs_to :site
  has_many :tags, dependent: :destroy

  after_destroy :delete_tags
  after_update  :shorten_url

  validates :url,:title, presence: true
  validates :url, length: {minimum: 3, maximum: 255, message: "%{value} Invalid length for the URL"}
  validates_with BookmarkUrlValidator

  def shorten_url
    short_url = (5...30).map { ('a'..'z').to_a[rand(26)] }.join
    bookmark = Bookmark.find_by(short_url: short_url)
    bookmark.present? ? self.short_url : self.short_url = short_url
  end

  private

  def delete_tags
    self.tags.destroy_all
  end

end
