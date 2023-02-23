class CreateJoinTablePlaylistUser < ActiveRecord::Migration[7.0]
  def change
    create_join_table :playlists, :users do |t|
      # t.index [:playlist_id, :user_id]
      # t.index [:user_id, :playlist_id]
    end
  end
end
