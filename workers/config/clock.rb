# config/clock.rb
require './config/boot'
require './config/environment'
require 'clockwork'

module Clockwork
  every(2.seconds, "Scrape news headlines") do
    ScraperWorker.perform_async
  end

  every(2.seconds, "Generate metadata for headlines") do
    MetadataWorker.perform_async
  end
end
