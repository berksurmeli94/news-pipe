class MetadataWorker
  include Sidekiq::Worker

  def perform
    Headline.where(metadata: nil).find_each do |headline|
      begin
        headline.update!(metadata: generate_metadata(headline))
      rescue StandardError => e
        Rails.logger.error "Failed to update metadata for headline #{headline.id}: #{e.message}"
      end
    end
  end
 
  private

  def generate_metadata(headline)
    Services::ChatgptMetadataAgent.call(title: headline.title, url: headline.url)
  rescue OpenAI::Error => e
    Rails.logger.error "OpenAI error while generating metadata for headline #{headline.id}: #{e.message}"
  rescue StandardError => e
    Rails.logger.error "Failed to generate metadata for headline #{headline.id}: #{e.message}"
    nil
  end
end
