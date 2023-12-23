require "test_helper"

class TaskTest < ActiveSupport::TestCase

  setup do
    @task = Task.new(title: "Test", description: "Test", project_id:0, start_date: DateTime.new(2023,1,1), expiration_date: DateTime.new(2023,1,31))
  end

  test "valid task" do
    task_test = @task
    assert task_test.valid?
  end

  test "task without title" do
    task_test = @task
    task_test.title = nil
    refute task_test.valid?
    assert_not_nil task_test.errors[:title]
  end

  test "task without description" do
    task_test = @task
    task_test.description = nil
    refute task_test.valid?
    assert_not_nil task_test.errors[:description]
  end

  test "task without project_id" do
    task_test = @task
    task_test.project_id = nil
    refute task_test.valid?
    assert_not_nil task_test.errors[:project_id]
  end

  test "task without start_date" do
    task_test = @task
    task_test.start_date = nil
    refute task_test.valid?
    assert_not_nil task_test.errors[:start_date]
  end

  test "task without expiration_date" do
    task_test = @task
    task_test.expiration_date = nil
    refute task_test.valid?
    assert_not_nil task_test.errors[:expiration_date]
  end

  test "task with conflicting dates" do
    task = Task.new(title: "Test", description: "Test", project_id:0, start_date: DateTime.new(2023,1,1), expiration_date: DateTime.new(2022,1,31))
    refute task.valid?
    assert_not_nil task.errors[:end_date_after_start_date]
  end



end
