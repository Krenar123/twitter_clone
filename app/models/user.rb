class User < ApplicationRecord
    MIN_PASS_LENGTH = 6
    MAX_PASS_LENGTH = 20
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    VALID_PASSWORD = /\A      # Must contain 8 or more characters
        (?=.*\d)           # Must contain a digit
        (?=.*[a-z])        # Must contain a lower case character
        (?=.*[A-Z])        # Must contain an upper case character
        (?=.*[[:^alnum:]]) # Must contain a symbol
    /x

    has_secure_password

    has_many :tweets, dependent: :destroy
    has_many :retweets, dependent: :destroy
    has_many :likes, dependent: :destroy
    
    before_save :downcase_email, :capitalize_name
    
    validates :password,length:{ in: (MIN_PASS_LENGTH)..(MAX_PASS_LENGTH), message: 'must contain at least 6 characters'},
    format: {with: VALID_PASSWORD, message: 'must contain digit, lower case, upper case and symbol'}
    validates :name,:email, presence: true
    validates :email,format: {with: VALID_EMAIL_REGEX},
                    case_sensitive: false,
                    uniqueness: {message: 'already exists.'}         

    private

    def downcase_email
        self.email = email.downcase
    end

    def capitalize_name
        self.name = name.capitalize
    end
end