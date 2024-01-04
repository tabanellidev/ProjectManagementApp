class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true
  validates :surname, presence: true

  enum role: [:developer, :developer_senior, :admin]

  has_many :assignments
  has_many :tasks, through: :assignments

  has_many :manages
  has_many :projects, through: :manages

  has_many :notifications, as: :recipient

  #Lista dei task su cui l'utente ha lavorato
  def self.workedTask(user)

    list = []

    user.assignments.each do |assignment|

      if assignment.status == 'Completed' or assignment.status == 'Delayed'
        list.append(assignment.task)
      end
    end

    list.uniq

  end

  #Lista dei progetti gestiti dall'utente in passato
  def self.projectManaged(user)

    list = []

    user.projects.each do |project|

      if project.status == 'Completed' or project.status == 'Delayed'
        list.append(project)
      end

    end

    list.uniq

  end







end
