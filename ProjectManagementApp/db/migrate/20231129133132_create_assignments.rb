class CreateAssignments < ActiveRecord::Migration[7.0]
  def change
    create_table :assignments do |t|
      t.belongs_to :user, null: false, default: 0, foreign_key: true
      t.belongs_to :task, null: false, foreign_key: true

      t.string :title
      t.string :description

      t.date :start_date
      t.date :expiration_date
      t.date :completion_date

      t.integer :status, default: 0

      t.timestamps
    end
  end
end
