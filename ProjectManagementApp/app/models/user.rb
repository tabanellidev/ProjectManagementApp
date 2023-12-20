class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: [:developer, :developer_senior, :admin]

  has_many :assignments
  has_many :tasks, through: :assignments

  has_many :manages
  has_many :projects, through: :manages

  has_many :notifications, as: :recipient

end
