class Project < ApplicationRecord

  validates :title, presence: true
  validates :description, presence: true
  validates :start_date, presence: true
  validates :expiration_date, presence: true

  validate :end_date_after_start_date

  enum status: [:Uncompleted, :Completed, :Expired, :Delayed]

  has_many :tasks

  has_many :manages
  has_many :users, through: :manages

  def end_date_after_start_date
    return if expiration_date.blank? || start_date.blank?

    if expiration_date < start_date
      errors.add(:expiration_date, "must be after the start date")
    end

 end


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

  def self.manager?(project, user)

    (project.users.distinct.pluck("id").include? user.id) or (user.role == 'admin')

  end




end
