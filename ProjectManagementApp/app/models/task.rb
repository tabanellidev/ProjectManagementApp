class Task < ApplicationRecord

  validates :title, presence: true
  validates :description, presence: true
  #validates :id_project, presence: true

  belongs_to :project, class_name: 'Project', foreign_key: 'project_id'

end
