class Movie < ApplicationRecord
  has_many :bookmarks
  validates :title, uniqueness: :true
end
