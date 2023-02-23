class CreateTracks < ActiveRecord::Migration[7.0]
  def change
    create_table :tracks do |t|
      t.string :title
      t.text :body
      t.string :file

      t.timestamps
    end
  end
end
