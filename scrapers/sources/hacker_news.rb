require "nokogiri"
require "open-uri"

module Sources
  class HackerNews
    URL = "https://news.ycombinator.com/"

    def self.fetch(limit = 5)
      doc = Nokogiri::HTML(URI.open(URL))
      doc.css(".titleline a").first(limit).map do |link|
        { source: "Hacker News", title: link.text.strip }
      end
    end
  end
end