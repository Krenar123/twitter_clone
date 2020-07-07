class Tweet < ApplicationRecord
    MIN_TWEET_LENGTH = 8
    MAX_TWEET_LENGTH = 50
    has_many :retweets, dependent: :destroy
    has_many :likes, dependent: :destroy
    
    belongs_to :user
    validates :tweet,presence: true, length: { in: (MIN_TWEET_LENGTH)..(MAX_TWEET_LENGTH) }
end
 