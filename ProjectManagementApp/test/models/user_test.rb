require "test_helper"

class UserTest < ActiveSupport::TestCase

  test "valid user" do
    user = User.new(name: 'John', surname: 'Doe', role: 0, email: 'johndoe@example.com', password:'testing', password_confirmation:'testing')
    assert user.valid?
  end


end
