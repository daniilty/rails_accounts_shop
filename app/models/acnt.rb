class Acnt < ApplicationRecord
  before_save { self.email = email.downcase }
  validates :email, presence: true
  validates :pass, presence: true
  
end
