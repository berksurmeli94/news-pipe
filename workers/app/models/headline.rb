# app/models/headline.rb
class Headline < ApplicationRecord
  def self.create_from_source(source)
    source.fetch.each.map do |data|
      find_or_create_by(title: data[:title], source: data[:source]) do |headline|
        headline.url = data[:url]
        headline.published_at = Time.current
      end
    end
  end
end
