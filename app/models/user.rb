class User < ApplicationRecord
    has_secure_password
    validates_presence_of :email, :password_digest
    before_create :confirmation_token
    
    private
    def confirmation_token
        if self.activation_digest.blank?
            self.activation_digest = SecureRandom.urlsafe_base64.to_s
        end
    end
end
