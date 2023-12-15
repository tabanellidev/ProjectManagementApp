require "test_helper"

class ProjectTest < ActiveSupport::TestCase

  test "valid project" do
    project = Project.new(title: "Test", description: "Test", start_date: DateTime.new(2023,1,1), expiration_date: DateTime.new(2023,1,31))
    assert project.valid?
  end

  test "project without title" do
    project = Project.new(description: "Test", start_date: DateTime.new(2023,1,1), expiration_date: DateTime.new(2023,1,31))
    refute project.valid?
    assert_not_nil project.errors[:title]
  end

  test "project without description" do
    project = Project.new(title: "Test", start_date: DateTime.new(2023,1,1), expiration_date: DateTime.new(2023,1,31))
    refute project.valid?
    assert_not_nil project.errors[:description]
  end

  test "project without start date" do
    project = Project.new(title: "Test", description: "Test", expiration_date: DateTime.new(2023,1,31))
    refute project.valid?
    assert_not_nil project.errors[:start_date]
  end

  test "project without expiration date" do
    project = Project.new(title: "Test", description: "Test", start_date: DateTime.new(2023,1,1))
    refute project.valid?
    assert_not_nil project.errors[:expiration_date]
  end

end
