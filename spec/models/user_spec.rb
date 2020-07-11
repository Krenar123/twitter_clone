require 'rails_helper'

RSpec.describe User do
  describe 'validations' do
    context 'presence' do
      it { should validate_presence_of(:name) }
      it { should validate_presence_of(:email) }
    end

    context 'length' do
      it { should validate_length_of(:password)
        .is_at_least(User::MIN_PASS_LENGTH)
        .is_at_most(User::MAX_PASS_LENGTH).with_message('must contain at least 6 characters') }
    end

    context 'password validations' do
      it { should have_secure_password }
      it { should validate_confirmation_of(:password) }
    end

    context 'format validations' do
      it { should allow_value('testing@gmail.com').for(:email) }
      it { should allow_value('Testing123!').for(:password) }
    end

    context 'tryning same with same email' do
      subject { create(:user) }
      it {  is_expected.to validate_uniqueness_of(:email).with_message("already exists.") }
    end
  end

  describe 'authentications' do
    it { should have_many(:tweets) }
    it { should have_many(:retweets) }
    it { should have_many(:likes) }

    context 'dependecies' do
      context 'when destroying' do 
        let(:user) { create(:user) }
        it 'should destroy all tweets' do
          create_list(:tweet, 1, user: user)
          expect { user.destroy }.to change { Tweet.count }.by(-1)
        end

        it 'should destroy all retweets' do
          create_list(:retweet, 1, user: user)
          expect { user.destroy }.to change { Retweet.count }.by(-1)
        end

        it 'should not destroy all likes' do
          tweet = create(:tweet)
          create_list(:like, 1, user: user,tweet: tweet)
          expect { user.destroy }.to change { Like.count }.by(-1)
        end
      end
    end
  end
end
