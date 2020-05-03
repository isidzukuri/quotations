# frozen_string_literal: true
module Scans
  class Ocr
    def initialize(scan)
      @scan = scan
    end

    def call      
      set_processing_status

      begin
        process_scan
      rescue => exception
        scan.status = Scan.statuses[:error]
        scan.log = exception.message
        scan.save

        raise exception
      end
    end

    private

    attr_reader :scan

    def set_processing_status
      scan.update_attribute(:status, Scan.statuses[:processing])
    end
    
    def process_scan
      scan.text = scanning_result[:text]
      scan.log = scanning_result[:log]
      scan.status = Scan.statuses[:scanned]
      scan.save
    end

    def image_base64
      Base64.strict_encode64(scan.image.read)
    end

    def scanning_result
      @scanning_result ||= VisionClient.new(image_base64).call
    end
  end
end