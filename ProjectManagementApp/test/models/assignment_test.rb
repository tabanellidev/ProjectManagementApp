require "test_helper"

class AssignmentTest < ActiveSupport::TestCase

  test "valid assignment" do
    assignment = Assignment.new(title: "Test", description: "Test", task_id:0, user_id:0, start_date: DateTime.new(2023,1,1), expiration_date: DateTime.new(2023,1,31))
    assert assignment.valid?
  end

  test "assignment without title" do
    assignment = Assignment.new(description: "Test", task_id:0, user_id:0, start_date: DateTime.new(2023,1,1), expiration_date: DateTime.new(2023,1,31))
    refute assignment.valid?
    assert_not_nil assignment.errors[:title]
  end

  test "assignment without description" do
    assignment = Assignment.new(title: "Test", task_id:0, user_id:0, start_date: DateTime.new(2023,1,1), expiration_date: DateTime.new(2023,1,31))
    refute assignment.valid?
    assert_not_nil assignment.errors[:description]
  end

  test "assignment without task_id" do
    assignment = Assignment.new(title: "Test", description: "Test", user_id:0, start_date: DateTime.new(2023,1,1), expiration_date: DateTime.new(2023,1,31))
    refute assignment.valid?
    assert_not_nil assignment.errors[:task_id]
  end

  test "assignment without user should not fail" do
    assignment = Assignment.new(title: "Test", description: "Test", task_id:0, start_date: DateTime.new(2023,1,1), expiration_date: DateTime.new(2023,1,31))
    assert assignment.valid?
  end

  test "assignment without start date" do
    assignment = Assignment.new(title: "Test", description: "Test", task_id:0, user_id:0, expiration_date: DateTime.new(2023,1,31))
    refute assignment.valid?
    assert_not_nil assignment.errors[:start_date]
  end

  test "assignment without end date" do
    assignment = Assignment.new(title: "Test", description: "Test", task_id:0, user_id:0, start_date: DateTime.new(2023,1,1))
    refute assignment.valid?
    assert_not_nil assignment.errors[:end_date]
  end

  test "assignment with conflicting dates" do
    assignment = Assignment.new(title: "Test", description: "Test", task_id:0, user_id:0, start_date: DateTime.new(2023,1,1), expiration_date: DateTime.new(2022,1,31))
    refute assignment.valid?
    assert_not_nil assignment.errors[:end_date_after_start_date]
  end

end
