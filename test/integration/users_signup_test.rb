require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test 'invalid signup information' do
    get signup_path

    assert_no_difference 'User.count' do
      post users_path, user: { name: '',
                               email: 'user@invalid',
                               password: '12345',
                               password_confirmation: '54321' }
    end
    assert_template 'users/new'
  end

  test 'valid signup information' do
    get signup_path

    assert_difference 'User.count', 1 do
      post_via_redirect users_path, user: {
        name: 'Example user',
        email: 'user@example.ru',
        password: '1',
        possword_confirmation: '1'
      }
    end
    assert_template 'users/show'
  end
end
