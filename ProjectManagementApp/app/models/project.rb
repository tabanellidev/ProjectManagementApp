class Project < ApplicationRecord

  validates :title, presence: true
  validates :description, presence: true

  has_many :tasks

  has_many :manages
  has_many :users, through: :manages

end
