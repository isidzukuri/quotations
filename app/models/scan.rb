class Scan < ApplicationRecord
  enum status: {
    initialized: 0,
    processing: 1,
    scanned: 2,
    error: 3
  }

  belongs_to :quotation, optional: true

  validates :text, length: { maximum: 10000 }, allow_blank: true
  validates :language, length: { is: 2 }, allow_blank: true
  validates :language, format: { with: /\A[a-z]+\z/ }, allow_blank: true  
end
