class Task < ApplicationRecord

  validates :title, presence: true
  validates :description, presence: true
  validates :project_id, presence: true

  belongs_to :project, class_name: 'Project', foreign_key: 'project_id'

  has_many :assignments
  has_many :users, through: :assignments

end
