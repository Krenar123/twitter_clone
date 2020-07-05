class AddUserToRetweets < ActiveRecord::Migration[6.0]
  def change
    add_reference :retweets, :user, foreign_key: true
  end
end
