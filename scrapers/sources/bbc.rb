require "nokogiri"
require "open-uri"

module Sources
  class BBC
    URL = "https://www.bbc.com/news"

    def self.fetch(limit = 5)
      doc = Nokogiri::HTML(URI.open(URL))
      doc.css("a.gs-c-promo-heading").first(limit).map do |link|
        { source: "BBC", title: link.text.strip }
      end
    end
  end
end
