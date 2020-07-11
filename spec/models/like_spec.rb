require 'rails_helper'

RSpec.describe Like do
    describe 'validations' do
        context 'presence' do
          it { should validate_presence_of(:tweet).with_message("must exist")}
          it { should validate_presence_of(:user).with_message("must exist") }
        end

        context 'uniqueness of tweet and user' do
            let(:user) { create(:user) }
            let(:tweet) { create(:tweet) }
            let(:like) { create(:like,user: user,tweet: tweet)}

            it 'should be true when saving just one' do
                like
                expect(like.valid?).to be true
            end

            it 'should be true when saving just two the same' do
                like
                like2 = build(:like, user: user,tweet: tweet) 
                expect(like2.valid?).to be false
            end
        end
    end
    
    describe 'authentications' do
        it { should belong_to(:tweet) }
        it { should belong_to(:user) }
    end
end
