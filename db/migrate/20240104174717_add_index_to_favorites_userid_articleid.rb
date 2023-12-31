class AddIndexToFavoritesUseridArticleid < ActiveRecord::Migration[7.0]
  def change
    add_index :favorites, :user_id
    add_index :favorites, :article_id
    add_index :favorites, [:user_id, :article_id], unique: true
  end
end
