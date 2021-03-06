class Mix < ActiveRecord::Base

  attr_accessible :full_title, :air_date, :mixesdb_url, :soundcloud_urls, :mixcloud_urls,
                  :youtube_urls, :hulkshare_urls, :zippyshare_urls, :hearthisat_urls

  has_and_belongs_to_many :artists
  has_and_belongs_to_many :genres
  has_and_belongs_to_many :events
  has_and_belongs_to_many :venues

  validates :full_title,  presence: true
  validates :mixesdb_url, presence: true, uniqueness: true

  scope :with_soundcloud, -> { where("array_length(soundcloud_urls, 1) > 0") }

  def self.download_soundcloud_files
    with_soundcloud.order('air_date DESC').each do |mix|
      mix.soundcloud_urls.each do |sc_url|
        begin
          puts mix.full_title.green
          puts sc_url.red

          path = "/Volumes/Murphy/workspace/essential/data/audio/soundcloud/#{mix.full_title.parameterize}"
          unless Dir.exists?(path)

            FileUtils.mkdir_p(path)
            pipe = IO.popen("otr #{sc_url} #{path}")
            pid = pipe.pid

            begin
              Timeout::timeout(350) do
                Process.wait(pid)
              end
            rescue Timeout::Error
              Process.kill('TERM', pid)
              puts "TIMED OUT -- #{mix.full_title}".red
            end
          end
        rescue => e
          puts "#{e.class}: #{e.message}".red
        end
      end
    end
  end
end
