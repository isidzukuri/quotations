# frozen_string_literal: true

module Authors
  class Create
    def initialize(params)
      @params = params
      @result = ExecutionResult.new
    end

    def call
      result[:author] = Author.find_by(full_name: params[:full_name])

      return result if result[:author]

      result[:author] = Author.new(params)

      create_author
      result
    end

    private

    attr_reader :params, :result

    def create_author
      result.errors!(result[:author].errors.messages) unless result[:author].save
    end
  end
end
