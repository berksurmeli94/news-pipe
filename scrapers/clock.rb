require "clockwork"
require_relative "./worker"
require "sidekiq"

module Clockwork
  every(30.seconds, "Scrape news headlines") do
    ScraperWorker.perform_async
  end
end