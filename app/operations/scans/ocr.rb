# frozen_string_literal: true
module Scans
  class Ocr
    def call(scan)
      @scan = scan
      
      set_processing_status

      begin
        scan.text = scanning_result[:text]
        scan.log = scanning_result[:log]
        scan.status = Scan.statuses[:scanned]
        scan.save
      rescue => exception
        scan.status = Scan.statuses[:error]
        scan.log = exception.message
        scan.save

        raise exception
      end
    end

    private

    attr_reader :scan

    def image_base64
      Base64.strict_encode64(scan.image.read)
    end

    def set_processing_status
      scan.update_attribute(:status, Scan.statuses[:processing])
    end

    def scanning_result
      @scanning_result ||= VisionClient.new.call(image_base64)
    end
  end
end