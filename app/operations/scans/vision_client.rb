# frozen_string_literal: true

module Scans
  class VisionClient
    Error = Class.new(StandardError)

    SERVICE = 'TEXT_DETECTION'
    HEADERS = { 'Content-Type' => 'application/json' }.freeze

    def call(image_base64)
      @image_base64 = image_base64
      # @image_base64 = Base64.strict_encode64(File.open(Rails.root+"spec/fixtures/quote.jpeg").read)
      response = request

      data = JSON.parse(response.body)

      if response.code.to_i == 200
        {
          text: data['responses'][0]['fullTextAnnotation']['text'],
          log: response.body
        }
      else
        raise Error, "[#{response.code}] #{data}"
      end
    end

    private

    attr_reader :image_base64

    def request_url
      "https://vision.googleapis.com/v1/images:annotate?key=#{Rails.application.credentials.google_vision_api_key}"
    end

    def request
      uri = URI.parse(request_url)

      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      request = Net::HTTP::Post.new(uri.request_uri, HEADERS)
      request.body = request_params.to_json

      http.request(request)
    end

    def request_params
      {
        requests: [
          {
            features: [{ type: SERVICE }],
            image: { content: image_base64 }
          }
        ]
      }
    end
  end
end
