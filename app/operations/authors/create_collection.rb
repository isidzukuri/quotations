# frozen_string_literal: true

module Authors
  class CreateCollection
    def initialize(authors_params)
      @authors_params = authors_params
      @result = ExecutionResult.new
    end

    def call
      result[:author_ids] = []
      authors_params.each do |author_params|
        if author_params[:id]
          result[:author_ids] << author_params[:id]
        else
          author_result = Authors::Create.new(author_params).call
          result[:author_ids] << author_result[:author].id if author_result.success?
        end
      end

      result
    end

    private

    attr_reader :authors_params, :result
  end
end
