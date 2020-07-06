require 'rails_helper'

RSpec.describe User do
  describe 'validations' do
    context 'presence' do
      it { should validate_presence_of(:name)}
      it { should validate_presence_of(:email)}
    end

    context 'length' do
      it { should validate_length_of(:password).is_at_least(6).is_at_most(20).with_message("must contain at least 6 characters")}
    end

    context 'password validations' do
      it { should have_secure_password }
      it { should validate_confirmation_of(:password) }
    end

    context 'format validations' do
      it { should allow_value('testing@gmail.com').for(:email) }
      it { should allow_value('Testing123!').for(:password) }
    end
  end

  describe 'authentications' do
    it { should have_many(:tweets) }
    it { should have_many(:retweets) }

    context 'dependecies' do
       context 'when destroying' do 
        let(:user) { create(:user) }
        it 'should destroy all tweets' do
          create_list(:tweet, 1, user: user)
          expect{user.destroy}.to change{Tweet.count}.by(-1)
        end

        it 'should destroy all retweets' do
          create_list(:retweet, 1, user: user)
          expect{user.destroy}.to change{Retweet.count}.by(-1)
        end
      end  
    end
  end
end
