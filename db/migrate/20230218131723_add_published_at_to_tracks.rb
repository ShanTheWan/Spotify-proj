class AddPublishedAtToTracks < ActiveRecord::Migration[7.0]
  def change
    add_column :tracks, :published_at, :datetime
  end
end
