class Tweet < ApplicationRecord
    has_many :retweets, dependent: :destroy
    has_many :likes, dependent: :destroy
    
    belongs_to :user
    validates :tweet, length: { in: 8..50 }
end
