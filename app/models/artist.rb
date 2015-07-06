class Artist < ActiveRecord::Base

  attr_accessible :name, :mixesdb_url

  has_and_belongs_to_many :mixes

  validates :name,  presence: true
  validates :mixesdb_url, presence: true, uniqueness: true
end
