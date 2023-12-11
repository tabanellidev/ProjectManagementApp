class Project < ApplicationRecord

  validates :title, presence: true
  validates :description, presence: true
  validates :start_date, presence: true
  validates :expiration_date, presence: true

  enum status: [:Uncompleted, :Completed, :Expired, :Delayed]

  has_many :tasks

  has_many :manages
  has_many :users, through: :manages

  def self.complete(project)

    puts("Completamento progetto")

    project_completed = true

    project.tasks do |task|
      if task.status == 'Uncompleted'
        project_completed = false
      end
    end

    if project_completed
      if Date.today <= project.expiration_date
        project.status = 'Completed'
      else
        project.status = 'Delayed'
      end

      project.save
    end

  end

  def self.expired

    puts("inizio project")

    @projects = Project.all

    @projects.each do |project|
      if project.status == 'Uncompleted'
        if Date.today > project.expiration_date
          project.status = 'Expired'
          project.save
        end
      end
    end

    puts("fine project")

  end

end
