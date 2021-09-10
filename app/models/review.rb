class Review < ApplicationRecord
  belongs_to :list

  validates :comment, :rating, presence: true
  validates :comment, length: { minimum: 6 }
end
