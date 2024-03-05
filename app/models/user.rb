class User < ApplicationRecord
    before_create :generate_api_key

    validates :name, :email, presence: :true
    validates :email, :api_key, uniqueness: { case_sensitive: false }
    validates :email, format: {with: URI::MailTo::EMAIL_REGEXP}
    validates_presence_of :password_digest

    has_many :favorites
    
    has_secure_password

    def generate_api_key
        self.api_key = SecureRandom.hex(32)
    end
end