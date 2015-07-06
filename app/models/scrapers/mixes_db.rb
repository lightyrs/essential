module Scrapers
  class MixesDB

    BASE_URL  = 'http://www.mixesdb.com'
    INDEX_URL = 'http://www.mixesdb.com/db/index.php?title=Category:Essential_Mix'

    def initialize
      @agent = Mechanize.new
    end

    def scrape_index!
      (1993..Time.now.year).each do |year|
        begin
          page = @agent.get("#{INDEX_URL}&pagefrom=#{year}")

          page.search('#catMixesList li > a').each do |link|
            begin
              mixesdb_url = "#{BASE_URL}#{link.attributes['href'].try(:value)}"
              full_title  = link.attributes['title'].value
              air_date    = full_title.match(/(\d{4}-\d{2}-\d{2})/ix).captures[0] rescue nil

              Mix.find_or_create_by(mixesdb_url: mixesdb_url) do |mix|
                mix.full_title = full_title
                mix.air_date   = DateTime.parse(air_date) unless air_date.nil?
              end
            rescue => e
              puts "#{e.class}: #{e.message}".red
            end
          end
        rescue => e
          puts "#{e.class}: #{e.message}".red
        end
      end
    end

    def scrape_resource!
      Mix.find_each do |mix|
        begin
          page = @agent.get(mix.mixesdb_url)

          page.search('#mw-normal-catlinks li > a').each do |link|
            begin
              unless link.match(/(\d{4})|Tracklist|Essential Mix/)
                category_page = link.click
                category = category_page.search('#mw-normal-catlinks li > a').first.text

                puts link.text.inspect.green
                puts link.category.inspect.blue

                case category
                when 'Artist'
                  artist = Artist.find_or_create_by(
                    name: link.text.gsub(' (Artist)', ''),
                    mixesdb_url: link.attributes['href'].to_s
                  )
                  mix.artists << artist
                when 'Style'
                  genre = Style.find_or_create_by(
                    name: link.text,
                    mixesdb_url: link.attributes['href'].to_s
                  )
                  mix.genres << genre
                when 'Event'
                  event = Event.find_or_create_by(
                    name: link.text,
                    mixesdb_url: link.attributes['href'].to_s
                  )
                  mix.events << event
                when 'Venue'
                  venue = Venue.find_or_create_by(
                    name: link.text,
                    mixesdb_url: link.attributes['href'].to_s
                  )
                  mix.venues << venue
                end

                mix.save
              end
            rescue => e
              puts "#{e.class}: #{e.message}".red
            end
          end

          page.search('[data-playersite]').each do |player|
            begin
              site = player.attributes['data-playersite'].to_s.gsub('data-playersite=', '').gsub('"', '')
              url  = player.attributes['data-playerurl'].to_s.gsub('data-playerurl=', '').gsub('"', '')

              case site
              when 'HulkShare'
                mix.hulkshare_url = url
              when 'SoundCloud'
                mix.soundcloud_url = url
              when 'hearthis.at'
                mix.hearthisat_url = url
              when 'Mixcloud'
                mix.mixcloud_url = url
              when 'YouTube'
                mix.youtube_url = url
              when 'Zippyshare'
                mix.zippyshare_url = url
              when 'play.fm'
                mix.playfm_url = url
              end
            rescue => e
              puts "#{e.class}: #{e.message}".red
            end
          end

          mix.save
        rescue => e
          puts "#{e.class}: #{e.message}".red
        end
      end
    end
  end
end
