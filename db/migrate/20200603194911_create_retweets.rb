class CreateRetweets < ActiveRecord::Migration[6.0]
  def change
    create_table :retweets do |t|
      t.string :rtweet
      t.references :tweet, null: false, foreign_key: true

      t.timestamps
    end
  end
end
