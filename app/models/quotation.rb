class Quotation < ApplicationRecord
  belongs_to :user, optional: true
  # belongs_to :book
  # has_one :scan
  # has_many :authors

  validates :percent,  inclusion: 1..100, allow_blank: true
  validates :text, length: { maximum: 10000 }, allow_blank: true
  validates :url, format: { with: URI.regexp }, allow_blank: true
  validates :language, length: { is: 2 }, allow_blank: true
  validates :language, format: { with: /\A[a-z]+\z/ }, allow_blank: true  
end
