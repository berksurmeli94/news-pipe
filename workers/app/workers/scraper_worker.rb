class ScraperWorker
  include Sidekiq::Worker

  def perform
    headlines = collect_and_save_headlines
    puts "Scraped #{headlines.size} headlines"

    headlines.each do |headline|
      publish_to_redis(headline)
    end
  end

  private

  def collect_and_save_headlines
    [
      Sources::HackerNews,
      Sources::Bbc,
      Sources::TechCrunch
    ].flat_map { |s| Headline.create_from_source(s) }
  end

  def publish_to_redis(headline)
    redis = Redis.new(url: ENV["REDIS_URL"])
    redis.publish("headlines_channel", {
      type: "headlines",
      data: headline.as_json(only: [:title, :url, :source, :published_at])
    }.to_json)
  end
end
