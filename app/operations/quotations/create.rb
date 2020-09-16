# frozen_string_literal: true

module Quotations
  class Create
    VALUABLE_ATTRIBUTES = %i[page percent url text].freeze

    def initialize(params)
      @scan_params = params.delete(:scan)
      @authors_params = params.delete(:authors)
      @params = params
      @result = ExecutionResult.new
    end

    def call
      result[:quotation] = Quotation.new(params)

      validate_empty_quotation

      return result unless result.success?

      create_scan
      
      return result unless result.success?

      create_quotation
      # add_book
      add_authors
      result
    end

    private

    attr_reader :params, :scan_params, :authors_params, :result

    def create_scan
      return unless scan_params&.dig(:image).present?

      scan_result = Scans::Create.new(scan_params).call

      result.errors!(scan_result.errors) unless scan_result.success?
    end

    def create_quotation
      result.errors!(result[:quotation].errors.messages) unless result[:quotation].save
    end

    def validate_empty_quotation
      unless scan_params&.dig(:image) || VALUABLE_ATTRIBUTES.any? { |attribute| params[attribute].present? }
        result.errors!({ quotation: [I18n.t('quotation.is_empty')] })
      end
    end

    def add_book
      # Books::Create.new(params, authors_params).call
    end

    def add_authors
      return unless authors_params.present? 

      # take_athors_from_book

      authors_result = Authors::CreateCollection.new(authors_params).call

      result[:quotation].author_ids = authors_result[:author_ids]
    end
  end
end
