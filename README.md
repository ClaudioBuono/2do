# 2DO - Task Tracking

Applicazione mobile sviluppata in **Flutter** per la gestione di una lista di attività (*to-do list*). 

---

## Modello dei Dati

L'app gestisce un'unica entità, **Attività**, definita dalle seguenti proprietà:

* **Titolo** (`String`): testo obbligatorio che descrive l'attività.
* **Stato** (`bool`): indica se l'attività è *da fare* (valore predefinito alla creazione) o *completata*.
* **Importanza** (`bool`): indica se l'attività è contrassegnata come *importante* (valore predefinito: `false`).

---

## Funzionalità Implementate

### R1 – Aggiunta di un'attività (S1)
* Navigazione verso la schermata di creazione di una nuova attività.
* Inserimento del titolo e selezione del flag di importanza.
* **Conferma**: ritorno alla schermata principale, aggiunta dell'attività all'elenco e visualizzazione di un messaggio temporaneo di conferma (`SnackBar`).
* **Validazione input**: se il titolo è vuoto al momento della conferma, l'app blocca la creazione e mostra un messaggio di errore, che scompare non appena l'utente inserisce un testo valido.
* **Annullamento**: tornando indietro (tramite UI o tasto indietro del dispositivo) senza confermare, nessuna attività viene creata e l'elenco rimane invariato.

### R2 – Consultazione delle attività (S2)
* Visualizzazione dell'elenco completo delle attività con **titolo**, **stato** e **importanza** chiaramente distinguibili.
* Contatore sempre visibile con il numero di **attività completate sul totale**.
* **Stato vuoto (*Empty State*)**: in assenza di attività, l'interfaccia mostra un'indicazione chiara su come aggiungerne una nuova.

### R3 – Aggiornamento dello stato (S3)
* Possibilità di contrassegnare un'attività come *completata* o riportarla a *da fare* direttamente dall'elenco.
* Aggiornamento immediato dell'interfaccia e del contatore delle attività completate.

### R4 – Eliminazione di un'attività (S4)
* Richiesta di eliminazione di una singola attività dall'elenco.
* Finestra di dialogo di **conferma** prima della rimozione definitiva (con possibilità di annullare l'operazione lasciando l'elenco invariato).
* Rimozione dell'elemento e aggiornamento istantaneo del conteggio.

---