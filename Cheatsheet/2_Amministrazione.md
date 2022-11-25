# **ADMINISTRATION**

***

**INDICE**:

- [**ADMINISTRATION**](#administration)
  - [**Intro amministrazione Server**](#intro-amministrazione-server)
  - [**CREATE/DROP SCHEMA**](#createdrop-schema)
    - [**RESTRICT, CASCADE**](#restrict-cascade)
  - [**CREATE TABLE**](#create-table)
  - [**Domini**](#domini)
    - [**Domini elementari**](#domini-elementari)
    - [**Domini user-defined**](#domini-user-defined)
  - [**VINCOLI**](#vincoli)
    - [**VINCOLI su un record**](#vincoli-su-un-record)
    - [**VINCOLI intrarelazionali**](#vincoli-intrarelazionali)
    - [**VINCOLI referenziali**](#vincoli-referenziali)

***

## **Intro amministrazione Server**

- SQL è un DML: un **DATA MANIPULATION LANGUAGE**, anche se ci sono anche **DATA DEFINITION LANGUAGES**
- Ad ogni **utente** viene associato un **database** creata dal **DBA**, (DataBase Administrator, l'amministratore del sistema) (root)
- La creazione consiste nel definire uno **schema**; tutti gli elementi vengono registrati in un **catalogo**
  - **Catalogo**: un database/schema che mantiene le informazioni su un altro database/schema, ovvero un **information schema**
- L'utente diventa amministratore: stabilisce gli accessi di eventuali altri utenti al proprio **database** (su/do, super user);
  - **Trasmissione di privilegi**: l'amministratore può delegare.

***

## **CREATE/DROP SCHEMA**

- Viene creato un database con un nome, e un utente viene identificato come amministratore
- Le definizioni creano gli elementi dello schema (Tabelle, viste, indici, etc)

```sql
CREATE SCHEMA NomeSchema
AUTHORIZATION Utente
[Definizioni]
```

- Per cancellare, si DROPPA

```sql
DROP SCHEMA NomeSchema
[RESTRICT/CASCADE]
```

### **RESTRICT, CASCADE**

Tutelano da errori:

- ```Restrict``` mi impedisce di cancellare databases non vuoti
- ```Cascade``` forza la cancellazione di tutto il db, e del contenuto al suo interno (una sorta di ```rm -rf``` su linux)

***

## **CREATE TABLE**

- Il ```CREATE TABLE``` definisce uno schema di relazione e ne crea una istanza vuota; specifica attributi, domini e vincoli
- Definendo una Primary Key viene assegnato un **indice** ordinato all'attributo (il che torna molto utile)

Esempio:  

```sql
CREATE TABLE Impiegato(
    Matricola CHAR(6) PRIMARY KEY,
    Nome CHAR(20) NOT NULL, 
    Cognome CHAR(20) NOT NULL, 
    Dipart CHAR(15),
    Stipendio NUMERIC(9) DEFAULT 0,
    FOREIGN KEY(Dipart) REFERENCES Dipartimento(NomeDip),
    UNIQUE(Cognome, Nome)
)
```

***

## **Domini**

### **Domini elementari**

- ```CHAR(n)``` : Stringhe di lunghezza n
- ```VARCHAR(n)``` : stringhe di lunghezza variabile con al massimo n caratteri. Usa uno spazio in più che restituisce la lunghezza effettiva della stringa
- ```INT / INTEGER``` :  interi
- ```REAL``` : reali
- ```NUMERIC(p, s)``` : p cifre di cui s decimali
- ```FLOAT(p)```
- ```DATE / TIME``` : per date e ore

### **Domini user-defined**

- E' possibile creare un dominio semplice user-defined con ```CREATE DOMAIN```
- Fondamentalmente è un dominio semplice con vincoli
- Utile per specificare gli intervalli validi: è possibile anche alternare i domini e i vincoli(?)

Esempio:  

```sql
CREATE DOMAIN Voto
AS SMALLINT DEFAULT NULL
CHECK (value >= 18 AND value <= 30)
```

***

## **VINCOLI**

- Controllati durante le operazioni di modifica
- Riguardano i valori ammissibili degli attributi di un record
- **Vincoli Intrarelazionali**: nell'ambito della stessa relazione
- **Vincoli Referenziali**: tra diverse relazioni
- Possono avere effetti negativi sulla prestazione

- In certi casi può essere utile limitare l'input stesso che un utente può inserire tramite una interfaccia: Vincola l'interfaccia che utilizza l'utente
  - Es: una dropdown choice al posto di un keyboard input, limita l'input che può mettere

- Vengono controllati durante le ```INSERT, DELETE, UPDATE```.
- Devono essere sempre soddisfatti altrimenti la transazione fallisce
- Servono a migliorare la qualità dei dati, arricchire la sintassi

- Alcuni tipi: ```NOT NULL```, ```UNIQUE```, ```PRIMARY KEY```, ```CHECK```
  - Nota: Primary Key implica ```NOT NULL```
  - ```UNIQUE``` definisce chiavi

- ```REFERENCES``` e ```FOREIGN KEY``` permettono di definire vincoli di integrità referenziale

### **VINCOLI su un record**

- ```NOT NULL```
  - Implicito se l'attributo fa parte di una chiave primaria
- ```CHECK [condizione]```
  - specifica i valori ammissibili (es: ```voto CHECK (18>= voto AND <=31)```)
  - Si può usare anche per attributi diversi dello stesso record
- ```DEFAULT [costante | NULL]```
  - Definisce quale sia il default di quel valore per ogni inserimento
- CHECK

### **VINCOLI intrarelazionali**

- ```UNIQUE```
  - L'attributo è una chiave
- ```PRIMARY KEY [nome chiave] (attributo/i)```
  - dove gli attributi devono essere dichiarati tutti NON NULL
- ```UNIQUE (attributo/i)```
  - definisce una chiave con più attributi

### **VINCOLI referenziali**
