module Scrapers
  class MixesDB
    # Scrape this mediawiki for essential mix data and links
    # to players or audio files.
    # http://www.mixesdb.com/db/index.php/Category:Essential_Mix
    # Pages are in this format:
    #
    # http://www.mixesdb.com/db/index.php?title=Category:Essential_Mix&pagefrom=1993
    # All you need is a year and you'll get 200 mixes starting from the given year.
    # These results may include results after the given year (but never before).
    #
    # So start at 1993 (when essential mixes premiered).

    BASE_URL = 'http://www.mixesdb.com'
    INDEX_URL = 'http://www.mixesdb.com/db/index.php?title=Category:Essential_Mix&pagefrom=1993'

    def initialize
      @agent = Mechanize.new
    end

    def matcher
      %r{
        (\d{4}-\d{2}-\d{2})                           # date
        \s-\s                                         # white space
        (?:([^-@]*)\s)?                                # artists
        (?:@\s)?                                      # place separator
        (.*)                                          # place
        (?:\s-\sEssential\sMix|\(Essential\sMix\))?   # suffix
      }ix
    end

    def scrape!
      @agent.get(INDEX_URL) do |page|
        page.search('#catMixesList a.cat-tlI').each do |link|
          captures = link.attributes['title'].value.match(matcher).try(:captures)

          if captures.nil?
            puts link.inspect
          else
            link = {
              date:    captures[0],
              artists: captures[1],
              place:   captures[2].gsub(/\s?-?\s?/(?:Essential Mix|\(Essential Mix\))/i, ''),
              url: "#{BASE_URL}#{link.attributes['href'].try(:value)}"
            }
            puts captures[2].inspect.blue
            puts link.inspect.green
          end
        end
      end
    end
  end
end
