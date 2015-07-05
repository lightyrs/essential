class Mix < ActiveRecord::Base

  attr_accessible :mixesdb_url, :soundcloud_url, :full_title,
                  :artist_string, :genre_string, :air_date

  validates :full_title,  presence: true
  validates :mixesdb_url, presence: true, uniqueness: true
end
