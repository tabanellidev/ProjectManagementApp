class Assignment < ApplicationRecord

  validates :title, presence: true
  validates :description, presence: true
  validates :task_id, presence: true
  validates :start_date, presence: true
  validates :expiration_date, presence: true

  validate :end_date_after_start_date

  enum status: [:Uncompleted, :Completed, :Expired, :Delayed]

  belongs_to :user, optional: true
  belongs_to :task

  has_noticed_notifications

  #Gestione delle notifiche
  def self.assignment_notice(assignment,type)

    #Per ogni tipo di notifica diversa ho possibili target diversi
    if type == 'Assigned'
      targets = assignment.user_id

      assignment = assignment.as_json
      assignment["type"] = "Assigned"
      assignment["object"] = "Assignment"
    end
    if type == 'Deallocated'
      targets = assignment.user_id

      assignment = assignment.as_json
      assignment["type"] = "Deallocated"
      assignment["object"] = "Assignment"
    end
    if type == 'Edit'
      targets = Project.managers(assignment.task.project)
      targets.append(assignment.user.id)
      targets = targets.uniq

      assignment = assignment.as_json
      assignment["type"] = "Edit"
      assignment["object"] = "Assignment"
    end
    if type == 'Created'
      targets = Project.managers(assignment.task.project)

      assignment = assignment.as_json
      assignment["type"] = "Created"
      assignment["object"] = "Assignment"
    end
    if type == 'Completed'
      targets = Project.managers(assignment.task.project)

      assignment = assignment.as_json
      assignment["type"] = "Completed"
      assignment["object"] = "Assignment"
    end
    if type == 'Soon Expired'
      targets = Project.managers(assignment.task.project)
      targets.append(assignment.user.id)
      targets = targets.uniq

      assignment = assignment.as_json
      assignment["type"] = "Soon Expired"
      assignment["object"] = "Assignment"
    end
    if type == 'Expired'
      targets = Project.managers(assignment.task.project)
      targets.append(assignment.user.id)
      targets = targets.uniq

      assignment = assignment.as_json
      assignment["type"] = "Expired"
      assignment["object"] = "Assignment"
    end
    if type == 'Delayed'
      targets = Project.managers(assignment.task.project)

      assignment = assignment.as_json
      assignment["type"] = "Delayed"
      assignment["object"] = "Assignment"
    end
    if type == 'Deleted'
      targets = Project.managers(assignment.task.project)
      targets.append(assignment.user.id)
      targets = targets.uniq

      assignment = assignment.as_json
      assignment["type"] = "Deleted"
      assignment["object"] = "Assignment"
    end

    ProjectNotification.with(assignment).deliver_later(User.find(targets))
  end

  #Per validation
  def end_date_after_start_date
    return if expiration_date.blank? || start_date.blank?

    if expiration_date < start_date
      errors.add(:expiration_date, "must be after the start date")
    end

  end

  #Funzioni supporto per i cronjob
  def self.expired

    puts("inizio assignment")

    @assignment = Assignment.all

    @assignment.each do |assignment|
      if assignment.status == 'Uncompleted'
        if (assignment.expiration_date - Date.today) == 7
          Assignemnt.assignment_notice(assignment,"Soon Expired")
        end
        if Date.today > assignment.expiration_date
         assignment.status = 'Expired'
         assignment.save
        end
      end
    end

    puts("fine asignment")

  end

  #Controllo che un utente sia colui assegnato al compito o un admin
  def self.owner(assignment, user)

    (assignment.user.id == user.id || user.role == 'admin')

  end

  #Cambiamento dello stato
  def self.complete(assignment)

    assignment.completion_date = Date.today

    if assignment.completion_date <= assignment.expiration_date
      assignment.status = 'Completed'
      Assignment.assignment_notice(assignment,'Completed')
    else
      assignment.status = 'Delayed'
      Assignment.assignment_notice(assignment,'Delayed')
    end

    assignment.save

    #Possibile cambiamento dello stato del task
    Task.complete(assignment.task)

  end

  #Funzione di supporto per le notifiche
  def self.create_and_assign_notification(assignment)
    Assignment.assignment_notice(assignment,'Created')

    if Assignment.not_user_zero(assignment)
       Assignment.assignment_notice(assignment,'Assigned')
    end
  end

  #Funzione di supporto per le notifiche
  def self.deallocate_and_assign_notification(assignment, old_id)

    if old_id == assignment.user_id
      Assignment.assignment_notice(assignment, 'Edit')
    else

      if Assignment.not_user_zero(assignment)
        Assignment.assignment_notice(assignment,'Assigned')
      end

      if old_id != 0
        @old_assignment = assignment
        @old_assignment.user_id = old_id
        Assignment.assignment_notice(@old_assignment,'Deallocated')
      end

    end

  end

  def self.not_user_zero(assignment)
    assignment.user_id != 0
  end

  #Dato un assignment ricavo i manager del progetto di cui fa parte, in supporto alle notifiche
  def self.manager?(id, current_user)

    assignment = Assignment.find(id)

    Project.manager?(assignment.task.project, current_user)

  end

  def self.set_expire(assignment)

    assignment.status = "Expired"
    assignment.save

  end

  def self.set_uncomplete(assignment)

    assignment.status = "Uncompleted"
    assignment.save

  end

  def self.set_delay(assignment)

    assignment.status = "Delayed"
    assignment.save

  end

end
