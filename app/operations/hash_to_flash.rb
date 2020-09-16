# frozen_string_literal: true

class HashToFlash
  def initialize(hash_object)
    @hash_object = hash_object
  end

  def call
    string = ''

    hash_object.each do |key, values|
      string += "#{key}:<br>- "
      string += values.join('<br>- ')
    end

    string
  end

  private

  attr_reader :hash_object
end
