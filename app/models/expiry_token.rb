class ExpiryToken < ApplicationRecord
  validates :exp_token, presence: true
  
end
