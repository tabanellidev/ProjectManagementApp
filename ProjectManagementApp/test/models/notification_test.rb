require "test_helper"

class NotificationTest < ActiveSupport::TestCase

  setup do

  end

  test "Project Notification Managers" do

    @project = Project.find(0)

    @mn = Project.managers(@project)

    Project.project_notice(@project,'Edit')

    @mn.each do |manager|
      assert Notification.find_by('recipient_id = ?', manager)
    end

    refute Notification.find_by('recipient_id = ?', 1)

  end

  test "Task Notification Managers" do

    @task = Task.find(0)

    @mn = Project.managers(@task.project)

    Task.task_notice(@task,'Created')

    @mn.each do |manager|
      assert Notification.find_by('recipient_id = ?', manager)
    end

    refute Notification.find_by('recipient_id = ?', 1)

  end

  test "Task Notification Managers + Task Group" do

    @task = Task.find(0)

    @mn = Project.managers(@task.project)

    Task.task_notice(@task,'Edit')

    @mn.each do |manager|
      assert Notification.find_by('recipient_id = ?', manager)
    end

    assert Notification.find_by('recipient_id = ?', 2)

    refute Notification.find_by('recipient_id = ?', 1)

  end

  test "Assignment Notification Target " do

    @assignment = Assignment.find(0)

    Assignment.assignment_notice(@assignment,'Assigned')

    assert Notification.find_by('recipient_id = ?', @assignment.user)

    refute Notification.find_by('recipient_id = ?', 1)

  end

  test "Assignment Notification Target + Managers " do

    @assignment = Assignment.find(0)

    @mn = Project.managers(@assignment.task.project)

    Assignment.assignment_notice(@assignment,'Edit')

    @mn.each do |manager|
      assert Notification.find_by('recipient_id = ?', manager)
    end

    assert Notification.find_by('recipient_id = ?', @assignment.user)

    refute Notification.find_by('recipient_id = ?', 1)

  end

end
