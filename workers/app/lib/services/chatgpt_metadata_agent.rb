module Services
    class ChatgptMetadataAgent
        def self.call(title:, url:)
            new(title, url).call
        end

        def initialize(title, url)
            @title = title
            @url = url
            @client = OpenAI::Client.new
        end

        def call
            prompt = <<~PROMPT
            You are a metadata generator for a content aggregation system.
            Given the title and URL of an article, generate the following:
            - A short summary (2-3 sentences)
            - 3-5 keywords
            - The sentiment (positive, negative, or neutral)

            Title: "#{@title}"
            URL: #{@url}
            PROMPT

            response = @client.chat(
            parameters: {
                model: "gpt-4",
                messages: [{ role: "user", content: prompt }],
                temperature: 0.7
            }
            )

            raw_content = response.dig("choices", 0, "message", "content")
            parse_response(raw_content)
        end

        private

        def parse_response(text)
            summary = text[/Summary:\s*(.*)/i, 1]&.strip
            keywords = text[/Keywords:\s*(.*)/i, 1]&.strip&.split(/,\s*/)
            sentiment = text[/Sentiment:\s*(.*)/i, 1]&.strip

            {
            summary: summary,
            keywords: keywords,
            sentiment: sentiment
            }
        end
    end
end
