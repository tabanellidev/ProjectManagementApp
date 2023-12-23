class CreateProjects < ActiveRecord::Migration[7.0]
  def change
    create_table :projects do |t|

      t.string :title
      t.string :description
      t.string :client

      t.date :start_date
      t.date :expiration_date
      t.date :completion_date

      t.integer :status, default: 0

      t.timestamps

    end
  end
end
