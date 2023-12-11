class Task < ApplicationRecord

  validates :title, presence: true
  validates :description, presence: true
  validates :project_id, presence: true
  validates :start_date, presence: true
  validates :expiration_date, presence: true

  belongs_to :project, class_name: 'Project', foreign_key: 'project_id'

  enum status: [:Uncompleted, :Completed, :Expired, :Delayed]

  has_many :assignments
  has_many :users, through: :assignments

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

end
