class Mix < ActiveRecord::Base

  attr_accessible :full_title, :air_date, :mixesdb_url, :soundcloud_url, :mixcloud_url,
                  :youtube_url, :hulkshare_url, :zippyshare_url, :hearthisat_url

  belongs_to :artist
  belongs_to :genre
  belongs_to :event
  belongs_to :venue

  validates :full_title,  presence: true
  validates :mixesdb_url, presence: true, uniqueness: true
end
