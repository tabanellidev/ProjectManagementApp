# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.create([{
  id: 0,
  email: 'unassigned@example.com',
  password:"unassigned",
  password_confirmation:"unassigned",
  name: "Unassigned",
  surname: "Unassigned"
},{
  email: 'test1@example.com',
  password:"testing1",
  password_confirmation:"testing1",
  role: 2,
  name: "Marco",
  surname: "Rossi"
},
{
  email: 'test2@example.com',
  password:"testing2",
  password_confirmation:"testing2",
  role: 1,
  name: "Giuseppe",
  surname: "Verdi"
},
{
  email: 'test3@example.com',
  password:"testing3",
  password_confirmation:"testing3",
  name: "Luca",
  surname: "Bianchi"
}
])

Project.create(title: "Sito e-commerce", description:"L'obiettivo è creare un sito di e-commerce per il cliente")
Project.create(title: "Creazione modello ML", description:"L'obiettivo del progetto è creare un modello di Machine Learning per la classificazione")

Task.create([{
  title: "Definizione Back-end",
  description: "Lorem ipsum dolor sit amet, consectetur adipisci elit",
  project_id: 1,
  completed: 0
},
{
  title: "Definizione Front-end",
  description: "Lorem ipsum dolor sit amet, consectetur adipisci elit",
  project_id: 1,
  completed: 0
},
{
  title: "Scelta del modello",
  description: "Lorem ipsum dolor sit amet, consectetur adipisci elit",
  project_id: 2,
  completed: 0
},
{
  title: "Serving",
  description: "Lorem ipsum dolor sit amet, consectetur adipisci elit",
  project_id: 2,
  completed: 0
}
])

Assignment.create([{
  title: "Definizione del modello",
  description: "Lorem ipsum dolor sit amet, consectetur adipisci elit",
  completed: 1,
  task_id: 1,
  user_id: 1
},
{
  title: "Test performance diveri motori",
  description: "Lorem ipsum dolor sit amet, consectetur adipisci elit",
  completed: 0,
  task_id: 1,
  user_id: 2
},
{
  title: "Costruzione Database",
  description: "Lorem ipsum dolor sit amet, consectetur adipisci elit",
  completed: 0,
  task_id: 1
},
{
  title: "Ricerca Template",
  description: "Lorem ipsum dolor sit amet, consectetur adipisci elit",
  completed: 0,
  task_id: 2,
  user_id: 3
},
{
  title: "Script di Utility",
  description: "Lorem ipsum dolor sit amet, consectetur adipisci elit",
  completed: 0,
  task_id: 2,
  user_id: 3
},
{
  title: "Test CNN",
  description: "Lorem ipsum dolor sit amet, consectetur adipisci elit",
  completed: 0,
  task_id: 3,
  user_id: 2
},
{
  title: "Test RNN",
  description: "Lorem ipsum dolor sit amet, consectetur adipisci elit",
  completed: 0,
  task_id: 3,
  user_id: 2
}
])

Manage.create([{
  project_id: 1,
  user_id: 1
},
{
  project_id: 1,
  user_id: 2
},
{
  project_id: 2,
  user_id: 3
}
])
