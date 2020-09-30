class Order < ApplicationRecord
  VALID_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 200 }, format: { with: VALID_REGEX }, uniqueness: true
end
