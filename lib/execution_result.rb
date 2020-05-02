class ExecutionResult
  attr_reader :data, :errors

  def initialize
    @data = {}
    @errors = {}
  end

  def success?
    errors.empty?
  end

  def []=(key, value)
    data[key] = value
  end

  def [](key)
    data[key]
  end
end