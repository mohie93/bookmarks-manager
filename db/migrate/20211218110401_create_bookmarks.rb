class CreateBookmarks < ActiveRecord::Migration[6.1]
  def change
    create_table :bookmarks do |t|
      t.string :url
      t.string :title
      t.string :short_url
      t.belongs_to :site, index: true, foreign_key: true
      t.timestamps
    end
  end
end
