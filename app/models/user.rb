class User < ApplicationRecord
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    
    has_secure_password

    before_save :downcase_email, :capitalize_name
    
    validates :name,:email, presence: true
    validates :email,format: {with: VALID_EMAIL_REGEX},
                    case_sensitive: false,
                    uniqueness: {message: 'Email is not valid'}

    private

    def downcase_email
        self.email = email.downcase
    end

    def capitalize_name
        self.name = name.capitalize
    end
end