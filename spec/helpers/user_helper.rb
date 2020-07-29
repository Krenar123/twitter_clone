module UserHelper
 def log_in(user)
    click_on 'Log In'
    within 'form' do
        fill_in 'Email', with: user.email
        fill_in 'Password', with: user.password

        click_button 'Login'
    end
 end

 def log_in_request(user)
    post_params = {
        params: {
            ss: {
                email: user.email,
                password: user.password
            }
        }
    }
    
    post auths_login_path, post_params
 end
end