require "nokogiri"
require "open-uri"

module Sources
  class TechCrunch
    URL = "https://techcrunch.com/"

    def self.fetch(limit = 5)
      doc = Nokogiri::HTML(URI.open(URL))
      doc.css("a.post-block__title__link").first(limit).map do |link|
        { source: "TechCrunch", title: link.text.strip }
      end
    end
  end
end