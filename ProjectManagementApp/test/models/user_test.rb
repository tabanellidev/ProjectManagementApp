require "test_helper"

class UserTest < ActiveSupport::TestCase

  setup do
    @user = User.new(name: 'John', surname: 'Doe', role: 0, email: 'johndoe@example.com', password:'testing', password_confirmation:'testing')

  end

  test "valid user" do
    test_user = @user
    assert test_user.valid?
  end

  test "user without name" do
    test_user = @user
    test_user.name = nil
    refute test_user.valid?
    assert_not_nil test_user.errors[:name]
  end

  test "user without surname" do
    test_user = @user
    test_user.surname = nil
    refute test_user.valid?
    assert_not_nil test_user.errors[:surname]
  end

  test "user without email" do
    test_user = @user
    test_user.email = nil
    refute test_user.valid?
    assert_not_nil test_user.errors[:email]
  end

  test "user without password" do
    test_user = @user
    test_user.password = nil
    refute test_user.valid?
    assert_not_nil test_user.errors[:password]
  end

  test "user with not password not matching" do
    test_user = @user
    test_user.password_confirmation = " "
    refute test_user.valid?
    assert_not_nil test_user.errors[:password_confirmation]
  end

end
