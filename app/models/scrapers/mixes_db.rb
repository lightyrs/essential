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

              Mix.find_or_create_by(mixesdb_url: mixesdb_url) do |mix|
                mix.full_title = full_title
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
  end
end
