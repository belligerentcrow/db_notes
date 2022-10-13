# Esercizi 2 - Modello relazionale

## 1

![Individuare le chiavi e i vincoli di integrità referenziale che sussistono nella seguente basi di dati. Individuare anche quali attributi possano ammettere valori null](media/immagine1.jpg)

***Chiavi***: 
    **Cod.** --> Chiave primaria nella relazione Pazienti <br>
    **(Paz. , Inizio)** --> Chiave nella relazione Ricoveri <br>
    **Matr.** --> Chiave primaria nella relazione Medici <br>
    **Cod.** --> Chiave primaria nella relazione Reparti <br>

Reparto è una chiave esterna di Ricoveri e di Medici. Riferisce la chiave primaria dello schema Reparti.
"Primario" è chiave esterna in Reparti, riferita alla chiave primaria di "Medici". <br><br>

***Vincoli di integrità***:<br>
    ->***Pazienti***: <br>
        * Il **codice** deve essere una stringa formata da una lettera seguita da tre cifre.<br>
        * Il **nome** dev'essere una stringa, anche il **cognome**.<br>
        * Ogni paziente deve avere un Codice<br>
        * Un codice è univoco per ogni paziente (Ognuno ne ha uno diverso)<br>
        * (Possono sussistere casi di omonimia.) <br><br>
    ->***Ricoveri***:<br>
        * **Paz.** --> Vedi **Codice** nello schema *Pazienti*<br>
        * sia **Inizio** che **Fine** vengono inseriti secondo la sintassi gg/mm/aa<br>
        * Uno stesso paziente non può avere ricoveri nello stesso lasso di tempo<br>
        * Idem sopra + non possono essere nello stesso lasso di tempo in due reparti diversi<br>
        * Lo stesso paziente può avere più ricoveri, e in reparti diversi, a patto che la fine del primo sia una data cronologicamente precedente all'inizio del secondo. <br>
        * **Reparto** deve essere un singolo carattere (maiuscolo)<br>
        * Ad ogni paziente deve essere associato almeno ad un inizio e ad un reparto.<br><br>
    ->***Medici***:<br>
        * **Matr**. è un intero a tre cifre<br>
        * **Cognome** e **Nome** --> Vedi cognome e nome in Pazienti<br>
        *  **Reparto** vedi **Reparto** in Ricoveri<br>
        *  Ad ogni matricola deve essere assegnato un nome ed un cognome (ammessi casi di omonimia) ed un reparto. <br>
        *  (Possono ovviamente esistere più medici in uno stesso reparto.)<br><br>
    -> ***Reparti***<br>
        * Ad ogni Codice deve essere assegnato un Nome e un Codice-Primario<br>
        * Il Codice Primario deve essere presente nella relazione Medici, e la matricola in Medici deve essere assegnata al reparto corrispondente. (Un medico deve essere primario del Reparto a cui è assegnato)<br>
        * Non può esistere più di un Primario per codice di Reparto.<br>
        * Ogni reparto ha un nome diverso. (Non sono ammessi casi di omonimia, altrimenti si tratterebbe dello stesso reparto.) OPPURE Sono ammessi casi di omonimia nel caso in cui esistano più reparti della stessa disciplina. <br><br>

Valori che possono assumere il valore NULL:<br>
    -> **FINE** nella relazione Ricoveri (Il paziente può non aver ancora finito il ricovero)<br>
    -> **PRIMARIO**, tecnicamente, se deve ancora essere assegnato<br>

***

## 2 - Esercizio

![Definire uno schema relazionale per organizzare le informazioni di un’azienda che ha impiegati (ognuno con codice fiscale, cognome, nome e data di nascita), filiali (con codice, sede e direttore, che è un impiegato). Ogni lavoratore lavora presso una filiale. Indicare le chiavi e i vincoli di integrità referenziale dello schema. Mostrare un’istanza della base di dati e verificare che soddisfa i vincoli.](media/esercizio2.jpg)

![Db dell'esercizio](media/immagine2_esercizio2.jpg)

***Chiavi***: <br> 
**CF** è chiave primaria della relazione **Impiegati**.<br>
**Codice Filiale** è chiave primaria della relazione **Filiali**. <br><br>

***Vincoli d'integrità***<br>
    * Ogni impiegato deve avere un nome e cognome e un CF, e una data di nascita<br>
    * Il CF è univoco per ogni impiegato. (D'altro canto, è possibile che due impiegati siano omonimi o che siano nati lo stesso giorno)<br>
    * Il CF è formato (in questo caso) da una stringa composta da 6 caratteri (3 presi dal cognome e 3 presi dal nome) seguiti da 3 cifre prese dalle unità di giorno mese e anno di nascita, seguiti da un altro carattere. <br>
    * Il Cognome e il Nome sono stringhe. 
    * la Data di Nascita dev'essere inserita in forma gg/mm/aa, e l'anno non può essere precedente al 1900, né superiore a (Anno_corrente - età_lavorativa_minima). Mese non può essere superiore a 12 e giorno superiore al giorno massimo del mese. Controllare i bisestili validi. <br>
    * Ogni impiegato deve lavorare in una filiale.<br> 
    * FILIALE nella relazione Impiegati è una chiave esterna, e si riferisce al CODICE FILIALE della relazione FILIALI<br><br>
    * Il codice della filiale dev'essere univoco per ogni diversa filiale. <br>
    * Possono / Non possono esserci più filiali nella stessa città? Incerto<br>
    * Ogni Filiale deve avere una SEDE e un DIRETTORE
    * Direttore è una chiave esterna di Filiale, e riferisce il CodiceFiscale della tabella impiegati (per riferirsi univocamente a uno ) E il DIRETTORE dev'essere un IMPIEGATO che lavora nella filiale DI CUI E' DIRETTORE<br>