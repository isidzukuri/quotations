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

  def errors!(messages)
    raise(ArgumentError, 'hash should be given') unless messages.is_a?(Hash)

    messages.each do |key, value|
      raise(ArgumentError, 'hash with array values should be given') unless value.is_a?(Array)

      (@errors[key.to_sym] ||= []).push(*value)
    end
  end
end