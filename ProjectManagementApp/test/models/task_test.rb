require "test_helper"

class TaskTest < ActiveSupport::TestCase

  test "valid task" do
    task = Task.new(title: "Test", description: "Test", project_id:0, start_date: DateTime.new(2023,1,1), expiration_date: DateTime.new(2023,1,31))
    assert task.valid?
  end

  test "task without title" do
    task = Task.new(description: "Test", project_id:0, start_date: DateTime.new(2023,1,1), expiration_date: DateTime.new(2023,1,31))
    refute task.valid?
    assert_not_nil task.errors[:title]
  end

  test "task without description" do
    task = Task.new(title: "Test", project_id:0, start_date: DateTime.new(2023,1,1), expiration_date: DateTime.new(2023,1,31))
    refute task.valid?
    assert_not_nil task.errors[:description]
  end

  test "task without project_id" do
    task = Task.new(title: "Test", description: "Test", start_date: DateTime.new(2023,1,1), expiration_date: DateTime.new(2023,1,31))
    refute task.valid?
    assert_not_nil task.errors[:project_id]
  end

  test "task without start date" do
    task = Task.new(title: "Test", description: "Test", project_id:0, expiration_date: DateTime.new(2023,1,31))
    refute task.valid?
    assert_not_nil task.errors[:start_date]
  end

  test "task without expiration date" do
    task = Task.new(title: "Test", description: "Test", project_id:0, start_date: DateTime.new(2023,1,1))
    refute task.valid?
    assert_not_nil task.errors[:expiration_date]
  end

end
