# frozen_string_literal: true

class Quotation < ApplicationRecord
  belongs_to :user, optional: true
  has_one :scan
  has_and_belongs_to_many :authors
  belongs_to :book, optional: true

  validates :percent, inclusion: 1..100, allow_blank: true
  validates :text, length: { maximum: 10_000 }, allow_blank: true
  validates :url, format: { with: URI::DEFAULT_PARSER.make_regexp }, allow_blank: true
  validates :language, length: { is: 2 }, allow_blank: true
  validates :language, format: { with: /\A[a-z]+\z/ }, allow_blank: true
end
