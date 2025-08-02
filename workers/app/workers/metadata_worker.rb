class MetadataWorker
  include Sidekiq::Worker

  def perform
    puts "Generating metadata..."
    Headline.where(metadata: nil).find_each do |headline|
      begin
        headline.metadata = generate_metadata(headline)
        headline.save!
      rescue StandardError => e
        Rails.logger.error "Failed to update metadata for headline #{headline.id}: #{e.message}"
      end
    end
  end
 
  private

  def generate_metadata(headline)
    Services::ChatgptMetadataAgent.call(title: "6 Weeks of Claude Code", url: "https://blog.puzzmo.com/posts/2025/07/30/six-weeks-of-claude-code/")
  rescue OpenAI::Error => e
    Rails.logger.error "OpenAI error while generating metadata for headline #{headline.id}: #{e.message}"
  rescue StandardError => e
    Rails.logger.error "Failed to generate metadata for headline #{headline.id}: #{e.message}"
    nil
  end
end
