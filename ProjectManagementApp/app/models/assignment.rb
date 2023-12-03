class Assignment < ApplicationRecord

  validates :title, presence: true
  validates :description, presence: true
  validates :task_id, presence: true

  enum completed: [:Uncompleted, :Completed]

  belongs_to :user, optional: true
  belongs_to :task
end
