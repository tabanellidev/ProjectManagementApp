class Assignment < ApplicationRecord

  validates :title, presence: true
  validates :description, presence: true
  validates :user_id, presence: true
  validates :task_id, presence: true

  belongs_to :user
  belongs_to :task
end
