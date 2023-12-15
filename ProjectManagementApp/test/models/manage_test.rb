require "test_helper"

class ManageTest < ActiveSupport::TestCase

  test "valid manage" do
    manage = Manage.new(user_id: 0, project_id: 0)
    assert manage.valid?
  end

  test "manage without user_id" do
    manage = Manage.new(project_id: 0)
    refute manage.valid?
    assert_not_nil manage.errors[:project_id]
  end

  test "manage without project_id" do
    manage = Manage.new(user_id: 0)
    refute manage.valid?
    assert_not_nil manage.errors[:user_id]
  end

end
