class Assignment < ApplicationRecord

  validates :title, presence: true
  validates :description, presence: true
  validates :task_id, presence: true
  validates :start_date, presence: true
  validates :expiration_date, presence: true


  enum status: [:Uncompleted, :Completed, :Expired, :Delayed]

  belongs_to :user, optional: true
  belongs_to :task


  def self.expired

    puts("inizio assignment")

    @assignment = Assignment.all

    @assignment.each do |assignment|
      if assignment.status == 'Uncompleted'
        if Date.today > assignment.expiration_date
         assignment.status = 'Expired'
         assignment.save
        end
      end
    end

    puts("fine asignment")

  end

  def self.owner(assignment, user)

    (assignment.user.id == user.id || user.role == 'admin')

  end

  def self.complete(assignment)

    assignment.completion_date = Date.today

    if assignment.completion_date <= assignment.expiration_date
      assignment.status = 'Completed'
    else
      assignment.status = 'Delayed'
    end

    assignment.save

    Task.complete(assignment.task)

  end

  def self.uncomplete(assignment)

    assignment.status = 0
    assignment.save

  end

  def self.expire(assignment)

    assignment.status = 2
    assignment.save

  end


end
