class Like < ApplicationRecord
  belongs_to :user
  belongs_to :tweet

  validates :tweet, uniqueness: { scope: :user}
end
