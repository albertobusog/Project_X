require "test_helper"

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name: " ", email: "t@t", password: "2", password_confirmation: "we" } }
    end
    assert_template 'users/new'
  end

  test "validate signup information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name: "Tony", email: "tony@example.com", password: "123456", password_confirmation: "123456" } }
    end
    follow_redirect!
    assert_template 'users/show'
    assert is_logged_in?
  end
end
