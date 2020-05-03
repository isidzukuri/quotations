# frozen_string_literal: true
module Scans
  class Create
    def initialize(scan_params)
      @scan_params = scan_params
      @result = ExecutionResult.new
    end

    def call  
      create_scan
      ocr
      result
    end

    private

    attr_reader :scan, :scan_params, :result

    def create_scan
      @scan = Scan.new(scan_params)
      result[:scan] = scan

      result.errors!(@scan.errors.full_message) unless scan.save
    end

    def ocr
      Scans::Ocr.new(@scan).call unless do_not_scan?
    end

    def do_not_scan?
      !scan.persisted? || ActiveModel::Type::Boolean.new.cast(scan_params[:do_not_scan])
    end
  end
end