class CallableClass
  attr_reader :params, :result

  def self.call(params = {})
    instance = new(params)
    instance.call
    instance.result
  end

  def initialize(params)
    @params = params
    @result = ExecutionResult.new
  end
end