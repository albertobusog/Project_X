require "test_helper"

class HtmlPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get root_path
    assert_response :success
    assert_select "title", "Home | Project_X"
  end

  test "should get help" do
    get help_path
    assert_response :success
    assert_select "title", "Help | Project_X"
  end

  test "should get about" do 
    get about_path
    assert_response :success
    assert_select "title", "About | Project_X"
  end


  test "should get contact page" do
    get contact_path
    assert_response :success
    assert_select "title", "Contact | Project_X"
  end

  test "should get singup page" do
    get singup_path
    assert_response :success
    assert_select "title", "Singup | Project_X"
  end
end
