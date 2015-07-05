module Scrapers
  class MixesDB

    BASE_URL  = 'http://www.mixesdb.com'
    INDEX_URL = 'http://www.mixesdb.com/db/index.php?title=Category:Essential_Mix'

    def initialize
      @agent = Mechanize.new
    end

    def matcher
      %r{
        (\d{4}-\d{2}-\d{2})                           # date
        \s-\s                                         # white space
        (?:([^-@]*)\s)?                               # artists
        (?:@\s)?                                      # context separator
        (.*)                                          # context
      }ix
    end

    def scrape_index!
      (1993..Time.now.year).map do |year|
        page = @agent.get("#{INDEX_URL}&pagefrom=#{year}")

        page.search('#catMixesList a.cat-tlI').map do |link|
          mixesdb_url = "#{BASE_URL}#{link.attributes['href'].try(:value)}"
          full_title  = link.attributes['title'].value
          captures    = full_title.match(matcher).try(:captures)

          Mix.find_or_create_by(mixesdb_url: mixesdb_url) do |mix|
            mix.full_title = full_title
          end

          # if captures.nil?
          #   puts full_title.inspect.red
          # else
          #   {
          #     date:    captures[0],
          #     artists: captures[1],
          #     place:   captures[2].gsub(/\s?-?\s?(?:Essential Mix|\(Essential Mix\))/i, ''),
          #     url:     "#{BASE_URL}#{link.attributes['href'].try(:value)}"
          #   }
          # end
        end
      end
    end
  end
end
