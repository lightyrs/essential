class Mix < ActiveRecord::Base

  attr_accessible :full_title, :air_date, :mixesdb_url, :soundcloud_urls, :mixcloud_urls,
                  :youtube_urls, :hulkshare_urls, :zippyshare_urls, :hearthisat_urls

  has_and_belongs_to_many :artists
  has_and_belongs_to_many :genres
  has_and_belongs_to_many :events
  has_and_belongs_to_many :venues

  validates :full_title,  presence: true
  validates :mixesdb_url, presence: true, uniqueness: true
end
