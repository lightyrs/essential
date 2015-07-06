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
              airdate     = full_title.match(/(\d{4}-\d{2}-\d{2})/ix).captures[0] rescue nil

              Mix.find_or_create_by(mixesdb_url: mixesdb_url) do |mix|
                mix.full_title = full_title
                mix.airdate    = DateTime.parse(airdate)
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
              # mix.genres = []
              # mix.artists = []
              # mix.venue = ''
              # mix.soundcloud_url = ''
              # mix.mixcloud_url = ''
            rescue => e
              puts "#{e.class}: #{e.message}".red
            end
          end
        rescue => e
          puts "#{e.class}: #{e.message}".red
        end
      end
    end
  end
end
