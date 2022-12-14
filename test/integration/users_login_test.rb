require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:gogi)
  end
  
  test "login empty fill" do
    get login_path

    assert_template 'new'
    post login_path, session: { email: "", password: ""}
    assert_template 'new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test "login with valid information" do
    get login_path

    post login_path, session: { email: @user.email, password: '1' }
    assert_redirected_to @user
    follow_redirect!

    assert_template "users/show"
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path, count: 1
    assert_select "a[href=?]", user_path(@user)
  end

  test "log out is profile" do
    get login_path

    post login_path, session: { email: @user.email, password: '1' }
    follow_redirect!
    assert_template "users/show"

    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_path
    follow_redirect!

    assert_select "a[href=?]", login_path, count: 1
    assert_select "a[href=?]", logout_path, count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
  end
end
