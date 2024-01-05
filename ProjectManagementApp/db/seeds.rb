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
  name: "Non",
  surname: "Assegnato"
},{
  email: 'admin@example.com',
  password:"adminadmin",
  password_confirmation:"adminadmin",
  role: 2,
  name: "Marco",
  surname: "Rossi"
},
{
  email: 'giuseppeverdi@example.com',
  password:"giuseppeverdi",
  password_confirmation:"giuseppeverdi",
  role: 1,
  name: "Giuseppe",
  surname: "Verdi"
},
{
  email: 'lucabianchi@example.com',
  password:"lucabianchi",
  password_confirmation:"lucabianchi",
  role: 1,
  name: "Luca",
  surname: "Bianchi"
},
{
  email: 'guglielmoblu@example.com',
  password:"guglielmoblu",
  password_confirmation:"guglielmoblu",
  role: 0,
  name: "Guglielmo",
  surname: "Blu"
},
{
  email: 'veronicaverde@example.com',
  password:"veronicaverde",
  password_confirmation:"veronicaverde",
  role: 0,
  name: "Veronica",
  surname: "Verde"
},
{
  email: 'lucarossi@example.com',
  password:"lucarossi",
  password_confirmation:"lucarossi",
  role: 0,
  name: "Luca",
  surname: "Rossi"
},
{
  email: 'martinagialli@example.com',
  password:"martinagialli",
  password_confirmation:"martinagialli",
  role: 0,
  name: "Martina",
  surname: "Gialli"
},
{
  email: 'caterinaneri@example.com',
  password:"caterinaneri",
  password_confirmation:"caterinaneri",
  role: 0,
  name: "Caterina",
  surname: "Neri"
},
{
  email: 'elisabettaviola@example.com',
  password:"elisabettaviola",
  password_confirmation:"elisabettaviola",
  role: 0,
  name: "Elisabetta",
  surname: "Viola"
},
{
  email: 'luciamarrone@example.com',
  password:"luciamarrone",
  password_confirmation:"luciamarrone",
  role: 0,
  name: "Lucia",
  surname: "Marrone"
}
])


Project.create([{
  title: "Sito e-commerce",
  description: "L'obiettivo è creare un sito di e-commerce per il cliente",
  client: "Cliente 1",
  start_date: DateTime.new(2023,10,1),
  expiration_date: DateTime.new(2024,1,31),
  completion_date: DateTime.new(2023,12,15)
},
{
  title: "Creazione modello ML",
  description: "L'obiettivo è creare un modello di Machine Learning in grado di fare classificazione in tempo reale",
  client: "Cliente 2",
  start_date: DateTime.new(2023,12,1),
  expiration_date: DateTime.new(2023,12,15),
  completion_date: DateTime.new(2023,12,5)
}
])

Task.create([{
  title: "Definizione Back-end",
  description: "Lorem ipsum dolor sit amet, consectetur adipisci elit",
  project_id: 1,
  status: 1,
  start_date: DateTime.new(2023,10,1),
  expiration_date: DateTime.new(2023,10,31),
  completion_date: DateTime.new(2023,10,15)
},
{
  title: "Definizione Front-end",
  description: "Lorem ipsum dolor sit amet, consectetur adipisci elit",
  project_id: 1,
  status: 1,
  start_date: DateTime.new(2023,11,1),
  expiration_date: DateTime.new(2023,11,30),
  completion_date: DateTime.new(2023,11,20)
},
{
  title: "Setup Prodotti",
  description: "Lorem ipsum dolor sit amet, consectetur adipisci elit",
  project_id: 1,
  status: 2,
  start_date: DateTime.new(2023,11,1),
  expiration_date: DateTime.new(2023,12,15),
},
{
  title: "Conoscenza Dominio",
  description: "Lorem ipsum dolor sit amet, consectetur adipisci elit",
  project_id: 2,
  status: 0,
  start_date: DateTime.new(2024,1,1),
  expiration_date: DateTime.new(2024,2,27)
},
{
  title: "Scelta del Modello",
  description: "Lorem ipsum dolor sit amet, consectetur adipisci elit",
  project_id: 2,
  status: 0,
  start_date: DateTime.new(2024,1,1),
  expiration_date: DateTime.new(2024,4,30)
}
])

Assignment.create([{
  title: "Definizione del modello",
  description: "Lorem ipsum dolor sit amet, consectetur adipisci elit",
  status: 1,
  task_id: 1,
  user_id: 1,
  start_date: DateTime.new(2023,10,1),
  expiration_date: DateTime.new(2023,10,20),
  completion_date: DateTime.new(2023,10,5)
},
{
  title: "Test performance diveri motori",
  description: "Lorem ipsum dolor sit amet, consectetur adipisci elit",
  status: 1,
  task_id: 1,
  user_id: 2,
  start_date: DateTime.new(2023,10,1),
  expiration_date: DateTime.new(2023,10,20),
  completion_date: DateTime.new(2023,10,7)
},
{
  title: "Costruzione Database",
  description: "Lorem ipsum dolor sit amet, consectetur adipisci elit",
  task_id: 1,
  user_id: 2,
  status: 1,
  start_date: DateTime.new(2023,10,1),
  expiration_date: DateTime.new(2023,10,25),
  completion_date: DateTime.new(2023,10,15)
},
{
  title: "Ricerca Template",
  description: "Lorem ipsum dolor sit amet, consectetur adipisci elit",
  task_id: 2,
  user_id: 8,
  status: 1,
  start_date: DateTime.new(2023,11,1),
  expiration_date: DateTime.new(2023,11,30),
  completion_date: DateTime.new(2023,11,15)
},
{
  title: "Script di Utility",
  description: "Lorem ipsum dolor sit amet, consectetur adipisci elit",
  task_id: 2,
  user_id: 9,
  status: 1,
  start_date: DateTime.new(2023,11,1),
  expiration_date: DateTime.new(2023,11,30),
  completion_date: DateTime.new(2023,11,20)
},
{
  title: "Inserimento prodotti",
  description: "Lorem ipsum dolor sit amet, consectetur adipisci elit",
  task_id: 3,
  user_id: 1,
  status: 2,
  start_date: DateTime.new(2023,12,1),
  expiration_date: DateTime.new(2023,12,31)
},
{
  title: "Test Prodotti",
  description: "Lorem ipsum dolor sit amet, consectetur adipisci elit",
  task_id: 3,
  user_id: 1,
  status: 2,
  start_date: DateTime.new(2023,12,1),
  expiration_date: DateTime.new(2023,12,31)
},
{
  title: "Dialogo Cliente",
  description: "Lorem ipsum dolor sit amet, consectetur adipisci elit",
  task_id: 4,
  user_id: 3,
  status: 0,
  start_date: DateTime.new(2024,1,1),
  expiration_date: DateTime.new(2024,1,31)
},
{
  title: "Analisi Papers",
  description: "Lorem ipsum dolor sit amet, consectetur adipisci elit",
  task_id: 4,
  user_id: 5,
  status: 0,
  start_date: DateTime.new(2024,1,1),
  expiration_date: DateTime.new(2024,1,31)
},
{
  title: "Test CNN",
  description: "Lorem ipsum dolor sit amet, consectetur adipisci elit",
  task_id: 5,
  user_id: 6,
  status: 0,
  start_date: DateTime.new(2024,1,1),
  expiration_date: DateTime.new(2024,2,27)
},
{
  title: "Test RNN",
  description: "Lorem ipsum dolor sit amet, consectetur adipisci elit",
  task_id: 5,
  user_id: 1,
  status: 0,
  start_date: DateTime.new(2024,1,1),
  expiration_date: DateTime.new(2024,2,27)
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
},
{
  project_id: 2,
  user_id: 4
}
])
