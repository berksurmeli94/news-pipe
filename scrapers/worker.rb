require "sidekiq"
require_relative "./scraper"

class ScraperWorker
  include Sidekiq::Worker

  def perform
    headlines = collect_headlines
    puts "Scraped #{headlines.size} headlines"
    publish_to_redis(headlines)
  end
end
