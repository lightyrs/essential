module Scrapers
  class MixesDB

    BASE_URL  = 'http://www.mixesdb.com'
    INDEX_URL = 'http://www.mixesdb.com/db/index.php?title=Category:Essential_Mix'

    def initialize
      @agent = Mechanize.new
    end

    def scrape_index!(start_date = 1993, end_date = Time.now.year)
      (start_date..end_date).each do |year|
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
        next if mix.artists.try(:any?)

        begin
          page = @agent.get(mix.mixesdb_url)

          page.search('#mw-normal-catlinks li > a').each do |link|
            begin
              link_text = link.text
              unless link_text.match(/(\d{4})|Tracklist|Essential Mix/)
                category_page = @agent.click(link)
                category = category_page.search('#mw-normal-catlinks li > a').first.text

                puts link_text.inspect.green
                puts category.inspect.blue

                case category
                when 'Artist'
                  artist = Artist.find_or_create_by(
                    name: link_text.gsub(' (Artist)', ''),
                    mixesdb_url: link.attributes['href'].to_s
                  )
                  mix.artists << artist
                when 'Style'
                  genre = Genre.find_or_create_by(
                    name: link_text,
                    mixesdb_url: link.attributes['href'].to_s
                  )
                  mix.genres << genre
                when 'Event'
                  event = Event.find_or_create_by(
                    name: link_text,
                    mixesdb_url: link.attributes['href'].to_s
                  )
                  mix.events << event
                when 'Venue'
                  venue = Venue.find_or_create_by(
                    name: link_text,
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
                mix.hulkshare_urls << url
              when 'SoundCloud'
                mix.soundcloud_urls << url
              when 'hearthis.at'
                mix.hearthisat_urls << url
              when 'Mixcloud'
                mix.mixcloud_urls << url
              when 'YouTube'
                mix.youtube_urls << url
              when 'Zippyshare'
                mix.zippyshare_urls << url
              when 'play.fm'
                mix.playfm_urls << url
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

    def get_new_mixes!
      scrape_index!(Time.now.year, Time.now.year + 1)
    end
  end
end
