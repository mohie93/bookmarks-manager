class Site < ApplicationRecord
  has_many :bookmarks, dependent: :destroy
end
