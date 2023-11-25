class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|

      t.string :title
      t.string :description

      t.timestamps
    end

    add_reference :tasks, :project, column: "project_id", foreign_key: true

  end
end
