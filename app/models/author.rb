# frozen_string_literal: true

class Author < ApplicationRecord
  has_many :quotations
  has_many :books

  validates :full_name, length: { in: 2..200 }
end
