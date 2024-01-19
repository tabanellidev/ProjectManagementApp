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
- **Notifiche** - Inviate agli utenti quando avvengono determinati eventi

![ER Diagram](/ProjectManagementApp/app/assets/images/er_diagram.png)

### Ruoli
Si dividono in
- **Admin** - utente con il potere più alto, hanno controllo su ogni aspetto dell'applicazione
- **Developer Senior** - hanno il potere principale di creare progetti e assegnare altri gestori
- **Developer** - non hanno poteri particolari, ma possono modificare lo stato di un compito indicando che l'hanno completato

Inoltre, ogni ruolo può essere anche un Project Manager che conferisce il potere di controllare Task e Compiti assegnati ad un progetto

|            | List         | Create       | Read         | Update       | Delete       |
| ------------ | ------------ | ------------ | ------------ | ------------ | ------------ |
|  Utenti  |  D | A  | D  |  A   | A  |
|  Progetti | D  | SD  | D  | D*  |  A |
|  Task | D  |  D* |  D | D*  | D* |
|  Compiti |  D |  D* |  D |  D* | D*   |
|  Gestioni |  D | SD*  |  D |  SD* | SD*  |

Legenda
- [D] - developer o superiore
- [SD] - senior developer o superiore
- [A] - admin
- [D*] - developer con potere da project manager ristretto a tale progetto
- [SD*] - senior developer con potere da project manager ristretto a tale progetto

### Ruoli per il testing
E' possibile testare subito l'applicazione utilizzando dei ruoli presenti nel seed del database:
|      Ruolo      | Email         | Password       |
| ------------ | ------------ | ------------ | 
|  Utente Admin  |  admin@example.com | adminadmin  | 
|  Utente Senior Developer | developersnr@example.com  | developer  | 
|  Utente Developer | developer@example.com  |  developer |



### Diagrammi 
- [Use-Case Diagram](/ProjectManagementApp/app/assets/images/UseCase.png)
- [Statechart](/ProjectManagementApp/app/assets/images/Statechart.png)

## Gemme principali utilizzate
- [Devise](https://github.com/heartcombo/devise) - Per la gestione e login degli utenti
- [Whenever](https://github.com/javan/whenever) - Per la gestione di cronjob
- [Noticed](https://github.com/excid3/noticed) - Per la gestione delle notifiche

### Whenever
La gemma Whenever viene utilizzata per modificare lo stato dei progetti / task / compiti.
Tutti gli oggetti partono da uno status
- Uncompleted

In particolare i compiti vengono modificati in
- Completed

Se l'utente assegnato ne dichiara il completamente prima della data di scadenza, altrimenti se l'oggetto
è ancora Uncompleted quando passa la data di scadenza lo stato diventa
- Expired

L'utente ha ancora la possibilità di completare il Compito ma lo stato diventa
- Delayed


I task seguono lo stesso ragionamento, ma Project Managers hanno l'opzione di completarli una volta che tutti i compiti al suo interno sono stati completati. Lo stesso per i progetti.

Whenever permette di creare dei cronjob che esegueno le istruzioni presenti nel file
```
ProjectManagementApp/config/schedule.rb
```
Al cui interno è specificata anche la pianificazione

## Prerequisiti

Per utilizzare l'applicazione tramite container è necessario
- Docker

Mentre per utilizzare l'applicazione al di fuori del container è necessario
- Bundler
- Ruby

## Guida all'installazione

Prima navigare nella cartella 

```
cd .../ProjectManagementApp/
```

Successivamente utilizzare docker build

```
docker build -t pma:1.0 .
```

Infine eseguire docker run mappando la porta 3000 al container

```
docker run -d -p 3000:3000 pma:1.0
```

Mentre per attivare i cronjob legati alla gemma whenever è necessario lanciare il comando

```
docker exec [id] cron
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

Lanciare il comando 
```
bundle install
```

Successivamente usare i comandi per attivare i cronjob 
```
bundle exec whenever
whenever --update-crontab --set environment=development
```

Usando il seguente comando è possibile verificare se i cronjob sono stati attivati correttamente 
```
crontab -l
```


### License

[MIT](/License.txt)