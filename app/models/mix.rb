class Mix < ActiveRecord::Base

  attr_accessible :full_title, :air_date, :mixesdb_url, :soundcloud_url, :mixcloud_url,
                  :youtube_url, :hulkshare_url, :zippyshare_url, :hearthisat_url

  has_and_belongs_to_many :artists
  has_and_belongs_to_many :genres
  has_and_belongs_to_many :events
  has_and_belongs_to_many :venues

  validates :full_title,  presence: true
  validates :mixesdb_url, presence: true, uniqueness: true
end
