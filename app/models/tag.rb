class TagsValidator < ActiveModel::Validator
  def validate(record)
    bookmark = Bookmark.find(record.bookmark_id)
    record.errors.add("Invalid bookmark") unless bookmark
  end
end

class Tag < ApplicationRecord
  validates :title, presence: true, length: { minimum: 5, max: 25, message: "%{value} Invalid length for the Tag" }
  validates_with TagsValidator
  belongs_to :bookmark

  def bulk_create
    tags_list = self.tags.map { |tag| { "bookmark_id": self.bookmark_id, "title": tag } }
    Tag.import tags_list
  end
end
