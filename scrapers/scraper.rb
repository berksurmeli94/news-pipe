require_relative "sources/hacker_news"
require_relative "sources/bbc"
require_relative "sources/techcrunch"
require "redis"

def collect_headlines
  sources = [
    Sources::HackerNews,
    Sources::BBC,
    Sources::TechCrunch
  ]
  sources.flat_map { |s| s.fetch(5) }
end

def publish_to_redis(headlines)
  redis = Redis.new(url: ENV["REDIS_URL"])
  redis.publish("headlines_channel", { type: "headlines", data: headlines }.to_json)
end
