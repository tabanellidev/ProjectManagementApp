# Project Management App
Project Managament App è uno strumento per la gestione di progetti con l'obiettivo di rendere chiara la divisione di compiti e organizzazione.

## Design
Viene utilizzato il framework **Ruby on Rails**, la cui architettura è ispirata al paradigma Model-View-Controller (MVC)

## Componenti principali
I componenti principali comprendono
- **Utenti** - A cui è possibile assegnare ruoli con permessi differenti
- **Progetti** - Divisibili in Task
- **Task** - Divisibili in Compiti
- **Compiti** - Assegnabili agli utenti
- **Gestioni** - Indicano quali Utenti hanno potere di gestire determinati progetti

![ER Diagram](https://github.com/tabanellidev/ProjectManagementApp/tree/main/ProjectManagementApp/app/assets/images/er_diagram.png)

### Ruoli
Si dividono in
- **Admin** - utente con il potere più alto, hanno controllo su ogni aspetto dell'applicazione
- **Developer Senior** - hanno il potere principale di creare progetti e assegnare altri gestori
- **Developer** - non hanno poteri particolari

Inoltre, ogni ruolo può essere anche un Project Manager che conferisce il potere di controllare Task e Compiti assegnati ad un progetto

[diagramma permessi]


## Gemme principali utilizzate
- [Devise](https://github.com/heartcombo/devise) - Per la gestione e login degli utenti
- [Whenever](https://github.com/javan/whenever) - Per la gestione di cronjob
- [Noticed](https://github.com/excid3/noticed) - Per la gestione delle notifiche


## Prerequisites

Per utilizzare al meglio l'applicazione dovrebbe essere già installato nel sistema
- Docker

Mentre per utilizzare l'applicazione al di fuori del container è necessario
- Bundler

## Guida all'installazione

Primo navigare nella cartella 


```
cd .../ProjectManagementApp/
```

Successivamente utilizzare docker build

```
docker build -t dockerfile .
```

Infine eseguire docker run mappando la porta 3000 al container

```
docker run -d -p 3000:3000 pma:1.0
```

Per fermare / rieseguire il container

```
docker start [id]
docker stop [id]
```

### Senza container

Se si desidera non utilizzare è container è necessario nagivare nella cartella

```
cd .../ProjectManagementApp/ProjectManagementApp/
```

E lanciare il comando 
```
bundle install
```

### License