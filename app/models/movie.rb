class Movie < ApplicationRecord
  validates :title, :overview, presence: true
  validates :title, uniqueness: true

  has_many :lists, through: :bookmarks
  has_many :bookmarks
  has_and_belongs_to_many :genres
end
