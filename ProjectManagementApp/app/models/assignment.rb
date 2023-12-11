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

end
