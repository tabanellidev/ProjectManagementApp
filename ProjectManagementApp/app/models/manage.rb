class Manage < ApplicationRecord

  validates :project_id, presence: true
  validates :user_id, presence: true

  belongs_to :user
  belongs_to :project


  def self.possibleManagers(userlist, project)

    possibleManagers = userlist - project.users

  end


end
