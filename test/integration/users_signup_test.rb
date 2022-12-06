require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test 'invalid signup information' do
    # Первым делом получим страницу регистрации
    get signup_path

    # Для теста отправки формы отправляем запрос POST по маршруту 
    # users_path

    # Assert_no_difference Утверждение что числовой  результат не изменится
    # до и после исполнения кода
    assert_no_difference 'User.count' do
      post users_path, user: { name: '',
                               email: 'user@invalid',
                               password: '12345',
                               password_confirmation: '54321' }
    end
    # Проверка повторного обращения к методу NEW при ошибочной регистрации
    assert_template 'users/new'

    # Ожидание что false окажется true
    assert_not flash.nil?
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

    assert flash.any?
  end

  test 'messages in errors' do
    get signup_path

    assert_no_difference 'User.count' do
      post users_path, user: { name: '',
                               email: 'user@invalid',
                               password: '12345',
                               password_confirmation: '54321' }
    end

    assert_template 'users/new'

    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'

    assert_select 'li', text: "Name can't be blank"
    assert_select 'li', text: "Email is invalid"
    assert_select 'li', text: "Password confirmation doesn't match Password"
    assert_select 'li', text: "Password is too long (maximum is 2 characters)"
  end
end
