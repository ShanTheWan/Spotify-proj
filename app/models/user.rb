class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable
         
  has_many :playlists, dependent: :destroy
  has_many :tracks, dependent: :destroy
  has_many :my_tracks, dependent: :destroy
end
