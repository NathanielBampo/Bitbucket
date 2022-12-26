require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:gogi)
  end
  
  test "messages small" do
    get login_path

    assert_template 'sessions/new'
    post login_path, session: { email: "", password: ""}
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test "login withc valid information" do
    get login_path

    post login_path, session: { email: @user.email, pasword: '1' }
    
  end
end
