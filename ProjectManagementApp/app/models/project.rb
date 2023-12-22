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

  has_noticed_notifications

  def self.project_notice(project,type)

    targets = managers(project)

    if type == 'Edit'
      project = project.as_json
      project["type"] = "Edit"
      project["object"] = "Project"
    end

    if type == 'Completed'
      project = project.as_json
      project["type"] = "Completed"
      project["object"] = "Project"
    end

    if type == 'Soon Expired'
      project = project.as_json
      project["type"] = "Soon Expired"
      project["object"] = "Project"
    end

    if type == 'Expired'
      project = project.as_json
      project["type"] = "Expired"
      project["object"] = "Project"
    end

    if type == 'Delayed'
      project = project.as_json
      project["type"] = "Delayed"
      project["object"] = "Project"
    end

    ProjectNotification.with(project).deliver_later(User.find(targets))
  end

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
        Project.project_notice(project,'Completed')
      else
        project.status = 'Delayed'
        Project.project_notice(project,'Delayed')
      end

      project.save
    end

  end

  def self.expired

    puts("inizio project")

    @projects = Project.all

    @projects.each do |project|
      if project.status == 'Uncompleted'
        if (project.expiration_date - Date.today) == 7
          Project.project_notice(project,"Soon Expired")
        end
        if Date.today > project.expiration_date
          project.status = 'Expired'
          Project.project_notice(project,'Expired')
          project.save
        end
      end
    end

    puts("fine project")

  end

  def self.manager?(project, user)
    (project.users.distinct.pluck("id").include? user.id) or (user.role == 'admin')
  end


  def self.managers(project)
    project.users.distinct.pluck("id")
  end

  def self.set_complete(project)

    project.status = "Completed"
    project.save

  end

  def self.set_expire(project)

    project.status = "Expired"
    project.save

  end

  def self.set_delay(project)

    project.status = "Delayed"
    project.save

  end

  def self.set_uncomplete(project)

    project.status = "Uncompleted"
    project.save

  end


end
