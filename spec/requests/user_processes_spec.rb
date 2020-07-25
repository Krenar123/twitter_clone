require 'rails_helper'

RSpec.describe "UserProcesses" do
  describe "Signing in and signing up" do
    describe 'Passing the valid parameters' do
      context 'when signin in' do
        it "should redirect us to user profile" do
          user = create(:user)
          post_params = {
            params: {
              ss: {
                email: user.email,
                password: user.password
              } 
            }
          }

          post '/auths/login', post_params

          expect(response).to have_http_status(:found)
          expect(response).to redirect_to(auths_user_path(user))
        end
      end

      context 'when signing up' do
        it 'should redirect to user profile' do
          post_params = {
            params: {
              user: {
                name: 'Test',
                email: 'test@gmail.com',
                password: 'Test123!',
                password_confirmation: 'Test123!'
              } 
            }
          }

          post '/auths/users', post_params

          user = User.last
          expect(response).to have_http_status(:found)
          expect(response).to redirect_to(auths_user_path(user))
        end

        context 'when creating user with same email' do
          it 'should pop a flash that "Email already exists" ' do
            user = create(:user)

            post_params = {
              params: {
                user: {
                  name: user.name,
                  email: user.email,
                  password: user.password,
                  password_confirmation: user.password
                } 
              }
            }

            post '/auths/users', post_params

            expect(response).to  render_template(:new)
            expect(response.body).to include("Email already exists.")
          end
        end
      end
    end

    describe 'Passing invalid parameters' do
      context 'when signing in' do 
        it 'should pop a flash that "Email and password doesnt match" ' do
          user = create(:user)
          post_params = {
            params: {
              ss: {
                email: user.email,
                password: ""
              } 
            }
          }

          post '/auths/login', post_params

          expect(response).to  render_template(:new)
          expect(response.body).to include("Email and password doesnt match")
        end
      end

      context 'when signing up' do
        it '' do
          post_params = {
            params: {
              user: {
                name: 'Test',
                email: 'test@gmail.com',
                password: '',
                password_confirmation: ''
              } 
            }
          }

          post '/auths/users', post_params

          expect(response).to  render_template(:new)
          expect(response.body).to include('Password can&#39;t be blank')
        end
      end
    end
  end

  describe 'As logged in user' do
    let(:user) { create(:user) }
    before do
      post_params = {
        params: {
          ss: {
            email: user.email,
            password: user.password
          } 
        }
      }

      post '/auths/login', post_params
    end

    context 'when editing your profile' do
      it 'should allow to redirect to edit profile' do
        get "/auths/users/#{user.id}/edit"

        expect(response).to have_http_status(:ok)
        expect(response.body).to include('Save changes')
      end
      
      it 'should allow to update' do
        post_params = {
          params: {
            user: {
              password: user.password,
              password_confirmation: user.password
            }
          }
        }

        patch "/auths/users/#{user.id}", post_params

        expect(response).to redirect_to(auths_user_path(user))
      end

      it 'should not allow to redirect to edit another user' do
        user_2 = create(:user)

        get "/auths/users/#{user_2.id}/edit"

        expect(response).to redirect_to(auths_user_path(user_2))
        follow_redirect!
        expect(response.body).to include('You dont have permission to edit!')
      end

      it 'should not allow to update another user' do
        user_2 = create(:user)

        post_params = {
          params: {
            user: {
              password: user.password,
              password_confirmation: user.password
            }
          }
        }

        patch "/auths/users/#{user_2.id}", post_params

        expect(response).to redirect_to(auths_user_path(user_2))
        follow_redirect!
        expect(response.body).to include('You dont have permission to edit!')
      end
    end
  end

  describe 'As not logged in user' do
    context 'when editing user' do
      it 'should not allow to redirect to edit another user' do
        user_2 = create(:user)

        get "/auths/users/#{user_2.id}/edit"

        expect(response).to redirect_to(auths_user_path(user_2))
        follow_redirect!
        expect(response.body).to include('You dont have permission to edit!')
      end

      it 'should not allow to update another user' do
        user_2 = create(:user)

        post_params = {
          params: {
            user: {
              password: user_2.password,
              password_confirmation: user_2.password
            }
          }
        }

        patch "/auths/users/#{user_2.id}", post_params

        expect(response).to redirect_to(auths_user_path(user_2))
        follow_redirect!
        expect(response.body).to include('You dont have permission to edit!')
      end
    end
  end
end
