# frozen_string_literal: true

class Author < ApplicationRecord
  has_and_belongs_to_many :quotations
  has_and_belongs_to_many :books

  validates :full_name, length: { in: 2..200 }
end
