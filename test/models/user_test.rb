require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Test User", email: "test@example.com", password: "123456", password_confirmation: "123456")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = "  "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "  "
    assert_not @user.valid?
  end

  test "name cannot be too long" do
    @user.name = "a" * 61
    assert_not @user.valid?
  end

  test "email cannot be too long" do
    @user.email = "a" * 255 + "@example.com"
    assert_not @user.valid?
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[tony@example.com JHON@test.com MARY_smith-01@new.com tony.smith@example.com tony+smith@example.com]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email vlaidation should not accept invalid email addresses" do
    invalid_addresses = %w[test@example,com test_at_example.com test@example. test@ex+ample.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email address should be unique" do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

  test "password should be present (can not be blank)" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "should have a minimum length" do
    @user.password = @user.password_confirmation = "p" * 5
    assert_not @user.valid?
  end

  test "associated snapshots should be destroyed" do
    @user.save
    @user.snapshots.create!(content: "great job")
    assert_difference 'Snapshot.count', -1 do 
      @user.destroy
    end
  end

  test "should folow and unfollow a user" do
    tony = users(:tony)
    jane = users(:jane)
    assert_not tony.following?(jane)
    tony.follow(jane)
    assert tony.following?(jane)
    assert jane.followers.include?(tony)
    tony.unfollow(jane)
    assert_not tony.following?(jane)
  end
end
