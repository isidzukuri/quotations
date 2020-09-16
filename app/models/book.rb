# frozen_string_literal: true

class Book < ApplicationRecord
  has_many :quotations
  has_and_belongs_to_many :authors

  validates :title, length: { in: 2..200 }
end
