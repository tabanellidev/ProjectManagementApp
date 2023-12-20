class Task < ApplicationRecord

  validates :title, presence: true
  validates :description, presence: true
  validates :project_id, presence: true
  validates :start_date, presence: true
  validates :expiration_date, presence: true

  validate :end_date_after_start_date

  belongs_to :project, class_name: 'Project', foreign_key: 'project_id'

  enum status: [:Uncompleted, :Completed, :Expired, :Delayed]

  has_many :assignments
  has_many :users, through: :assignments

  has_noticed_notifications

  def self.task_notice(task,type)

    if type == 3
      task_to_send = task.as_json
      task_to_send["type"] = "Edit"
      task_to_send["object"] = "Task"
    end

    ProjectNotification.with(task_to_send).deliver_later(task_group(task))
  end

  def end_date_after_start_date
    return if expiration_date.blank? || start_date.blank?

    if expiration_date < start_date
      errors.add(:expiration_date, "must be after the start date")
    end

 end

  def self.complete(task)

    puts("Completamento task")

    task_completed = true

    task.assignments.each do |assignment|
      if assignment.status == 'Uncompleted'
        task_completed = false
      end
    end

    if task_completed
      if Date.today <= task.expiration_date
        task.status = 'Completed'
      else
        task.status = 'Delayed'
      end
      task.save

      Project.complete(task.project)

    end

  end

  def self.expired

    puts("inizio task")

    @tasks = Task.all

    @tasks.each do |task|
      if task.status == 'Uncompleted'
        if Date.today > task.expiration_date
          task.status = 'Expired'
          task.save
        end
      end
    end

    puts("fine project")

  end

  def self.set_complete(task)

    task.status = "Completed"
    task.save

  end

  def self.set_expire(task)

    task.status = "Expired"
    task.save

  end

  def self.set_uncomplete(task)

    task.status = "Uncompleted"
    task.save

  end

  def self.task_group(task)

    ids = task.assignments.group(:user_id).pluck("id")
    users = User.find(id)

  end

end
