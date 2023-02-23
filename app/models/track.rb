class Track < ApplicationRecord
    belongs_to :user
    has_and_belongs_to_many :playlists
    validates_presence_of :title, :body, :file
    has_one_attached :file, dependent: :destroy
    scope :published, -> { where(published_at: nil).or(where("published_at <= ?", DateTime.now)) }
end
