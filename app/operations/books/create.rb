# frozen_string_literal: true

module Books
  class Create
    def initialize(params, authors_params)
      @params = params
      @authors_params = authors_params
      @result = ExecutionResult.new
    end

    def call
      return result if book_exists?

      create_book

      return result unless result.success?

      result[:book].author_ids = author_ids 

      result
    end

    private

    attr_reader :params, :authors_params, :result

    def author_ids
      return [] unless authors_params.present?

      @author_ids ||= Authors::CreateCollection.new(authors_params).call[:author_ids]
    end

    def book_exists?
      books_with_same_title = Book.where(title: params[:title])

      books_with_same_title.each do |book|
        if (author_ids - book.author_ids).empty?
          result[:book] = book

          return true
        end
      end

      false
    end

    def create_book
      result[:book] = Book.new(params)

      result.errors!(result[:book].errors.messages) unless result[:book].save
    end
  end
end
