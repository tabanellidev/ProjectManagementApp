# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.create(email: 'test1@example.com', password:"testing1", password_confirmation:"testing1")
User.create(email: 'test2@example.com', password:"testing2", password_confirmation:"testing2")

Project.create(title: "Project Title n. #1", description:"Project Description n. #1")
Project.create(title: "Project Title n. #2", description:"Project Description n. #2")

Task.create([{
  title: "Task 1",
  description: "Description 1",
  project_id: 1
},
{
  title: "Task 2",
  description: "Description 2",
  project_id: 1
},
{
  title: "Task 3",
  description: "Description 3",
  project_id: 1
},
{
  title: "Task 4",
  description: "Description 4",
  project_id: 2
},
{
  title: "Task 5",
  description: "Description 5",
  project_id: 2
}
])

Assignment.create([{
  title: "Assignments 1",
  description: "Description 1",
  task_id: 1,
  user_id: 1
},
{
  title: "Assignments 2",
  description: "Description 2",
  task_id: 1,
  user_id: 2
}
])
