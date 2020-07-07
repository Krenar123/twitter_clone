class Retweet < ApplicationRecord
  MIN_RTWEET_LENGTH = 10
  MAX_RTWEET_LENGTH = 100
  belongs_to :tweet
  belongs_to :user
  validates :rtweet, presence: true, length: {in: (MIN_RTWEET_LENGTH)..(MAX_RTWEET_LENGTH)}
end
