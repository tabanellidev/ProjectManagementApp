require "test_helper"

class ProjectTest < ActiveSupport::TestCase

  setup do
    @project = Project.new(title: "Test", description: "Test", client: "Client 1", start_date: DateTime.new(2023,1,1), expiration_date: DateTime.new(2023,1,31))
  end

  test "valid project" do
    test_project = @project
    assert test_project.valid?
  end

  test "project without title" do
    #project = Project.new(description: "Test", client: "Client 1", start_date: DateTime.new(2023,1,1), expiration_date: DateTime.new(2023,1,31))
    test_project = @project
    test_project.title = nil
    refute test_project.valid?
    assert_not_nil test_project.errors[:title]
  end

  test "project without description" do
    test_project = @project
    test_project.description = nil
    refute test_project.valid?
    assert_not_nil test_project.errors[:description]
  end

  test "project without client" do
    test_project = @project
    test_project.client = nil
    refute test_project.valid?
    assert_not_nil test_project.errors[:client]
  end

  test "project without start date" do
    test_project = @project
    test_project.start_date = nil
    refute test_project.valid?
    assert_not_nil test_project.errors[:start_date]
  end

  test "project without expiration date" do
    test_project = @project
    test_project.expiration_date = nil
    refute test_project.valid?
    assert_not_nil test_project.errors[:expiration_date]
  end

  test "project with conflicting dates" do
    project = Project.new(title: "Test", description: "Test", client: "Client 1", start_date: DateTime.new(2023,1,1), expiration_date: DateTime.new(2022,1,31))
    refute project.valid?
    assert_not_nil project.errors[:end_date_after_start_date]
  end

end
