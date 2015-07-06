class Venue < ActiveRecord::Base

  attr_accessible :name, :mixesdb_url

  has_many :mixes

  validates :full_title,  presence: true
  validates :mixesdb_url, presence: true, uniqueness: true
end
