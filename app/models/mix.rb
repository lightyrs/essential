class Mix < ActiveRecord::Base

  attr_accessible :mixesdb_url, :soundcloud_url, :mixcloud_url, :youtube_url,
                  :hulkshare_url, :zippyshare_url, :hearthisat_url :full_title,
                  :artists, :genres, :air_date, :venue

  validates :full_title,  presence: true
  validates :mixesdb_url, presence: true, uniqueness: true
end
