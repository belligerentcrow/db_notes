# **DB - 12 _ RIPASSO**

> grazie lele <3333

## **VISTE** 

* Le view possono essere consultate: Sono tabelle ausiliarie virtuali "create al volo"
* Utilizzate per:
  * Semplificazione
  * Protezione dati/sicurezza accesso (utenti che possono accedere solo ad alcune informazioni)
  * Scomposizioni di query complesse
  * Riorganizzazione dei dati secondo nuovi schemi
* Una volta creata, possiamo utilizzarla come una tabella normale in una qualsiasi query.
<br><br>

### **SINTASSI**

```sql
CREATE VIEW NomeView (Attributi,..) AS
--attributi omissibili se la SELECT ha attributi con nomi
SELECT Attributi... 
FROM tabella
```

**ESEMPIO**

```sql
CREATE VIEW MediaVoti (Matricola, Media) AS
    SELECT Matricola, AVG(Voto)
    FROM Esami
    GROUP BY Matricola
```

uso:

```sql
    SELECT *
    FROM MediaVoti
```

* Quando eseguiamo una query avente la View nella FROM, il DBMS prende la definizione della View (salvata in memoria secondaria) e nella query sostituirà il codice della View nella chiamata ad essa.
* La view viene calcolata in quel momento(al volo), e il risultato viene posto in memoria principale

***

### **ESEMPIO di utilizzo**

```sql
CREATE VIEW AgentePerZona (Zona, NumAg)
AS 
SELECT Zona, COUNT(*)
FROM AGENTI
GROUP BY Zona
```

```sql
SELECT AVG(NumAg)
FROM AgentePerZona
```

(Altrimenti: )

```sql
SELECT AVG(NumAg)
FROM (SELECT Zona, COUNT(*) AS NumAg
      FROM AGENTI
      GROUP BY Zona)
```

***

### **Uso per sicurezza**

Data la relazione ClientiBancari(Nome, Indirizzo, **Saldo**); 

```sql
CREATE VIEW Clienti AS
SELECT Nome,Indirizzo
FROM ClientiBancari
```

^-- non viene visualizzato il saldo

***

## **CANCELLAZIONE VISTE**

Si usa il comando **DROP**.  

```sql
DROP VIEW NomeView [RESTRICT|CASCADE]
```

* Con **RESTRICT** non viene cancellata se è utilizzata in altre viste: blocca l'esecuzione
* Con **CASCADE**, verranno rimosse sia la Vista che tutte le viste che utilizzano la View o la Tabella rimossa
* La distruzione di una View **NON ALTERA le tabelle** su cui la VIEW si basa!!

***

### **Utilizzo come tabella**

* Una view può essere definita sulla base di un'altra View
* (Nelle prime versioni di SQL non era possibile modificare una view tramite insert/delete/update ma ora non è più così)

* Che succede se una tabella usata in una VIEW viene alterata o cancellata senza specificare RESTRICT o CASCADE?? 
  * Dipende dal DBMS.
  * La VIEW può essere marcata come inoperativa
  * Oppure la modifica e la cancellazione vengono negate

***

## **MASCHERARE l'organizzazione logica dei dati tramite VIEWS**

Tabella di esempio:  

* **AGENTI(CodiceAgente, Nome, Zona, Commissione, Supervisore);**

* Potrebbe essere necessario modificare la struttura del DATABASE

    Esempio:
        Si decide che "SUPERVISORE" non è più legato ai singoli agenti, ma è legato alla ZONA.
        Vogliamo quindi separare la tabella agenti in due tabelle diverse. 

1. Creiamo la tabella ZONA:

```sql
CREATE TABLE ZoneTab(Zona CHAR(8), Supervisore CHAR(3))
AS SELECT DISTINCT Zona, Supervisore
FROM Agenti
```

2. Poi una nuova tabella per gli agenti

```sql
CREATE TABLE NuoviAgenti
    AS SELECT CodiceAgente, Nome, Zona, Commissione
    FROM Agenti
```

3. Dopo aver spostato i dati nelle apposite tabelle nuove, possiamo fare la drop di Agenti
   
```sql
    DROP Agenti
```

4. Infine creiamo una VIEW chiamandola AGENTI per ricreare il comportamento della struttura originale del database

```sql
CREATE VIEW Agenti
    AS SELECT *
    FROM NuoviAgenti NATURAL JOIN
```

* In questo modo modifichiamo la struttura del DB senza modificare le query pregresse; esse funzioneranno comunque.  
* Se la "Rappresentazione normalizzata" (to be continued) è diversa da quella che richiede la query, la view attua query semplificate

***

## **Aggiornamento delle VIEW** 

* Possiamo modificare una view: ha senso in caso di accesso controllato. 

* **Fare una insert in una view corrisponde a fare una insert nella tabella principale**
* I dati mancanti saranno inseriti a NULL --> se ammesso dai vincoli. Altrimenti riceveremo un errore generico (in modo da mantenere sicurezza, l'utente potrebbe non essere abilitato a vederli con i suoi permessi.)
* Una insert su una view composta da più tabelle in generale non è consentita nella maggior parte dei DBMS. 

* In generale: 
  * una VIEW definita su una singola tabella è modificabile se gli attributi della VIEW contengono la chiave primaria e le altre chiavi; 
  * le VIEWS definite su più tabella non sono aggiornabili; 
  * Le VIEWS che usano funzioni di aggregazione non sono aggiornabili
  * Ogni riga e colonna della VIEW deve corrispondere a una e una sola riga e colonna della tabella base
  
***

## **ESEMPIO 1**

    AEROPORTO(Città, Nazione,NumPiste);
        VOLO(IdVolo,GiornoSett,CittaPart,OraPart,CittaArr,OraArr,TipoAereo);
    
    AEREO(TipoAereo,NumPasseggeri,QtaMerci)

* Scrivere, facendo uso di una vista, l'interrogazione SQL che permette di determinare il massimo numero di passeggeri che possono arrivare in un aeroporto italiano dalla Francia di giovedì (se vi sono più voli, si devono sommare i passeggeri).

```sql
CREATE VIEW Passeggeri(Numero)
AS SELECT SUM(NumPasseggeri)
FROM AEREOPORTO AS A1 JOIN VOLO ON A1.Citta=CittaPart
JOIN AEREOPORTO AS A2 ON A2.Citta=CittaArr
JOIN AEREO ON VOLO.TipoAereo=Aereo.TipoAereo

WHERE A1.Nazione="Francia" AND A2.Nazione="Italia" AND GiornoSett="Giovedì"
GROUP BY A2.Citta

SELECT MAX(Numero)
FROM Passeggeri
```

***

## **ESEMPIO 2** 

* Definire una vista che mostra per ogni dipartimento il valore medio degli stipendi superiori alla media 
del dipartimento

```sql
CREATE VIEW SalariSopraMedia(Dipartimento,Stipendio)
AS SELECT Dipartimento, AVG(Stipendio)
FROM Impiegato AS I
WHERE Stipendio > (
    SELECT AVG(I2.Stipendio)
    FROM Impiegato AS I2
    WHERE I.Dipartimento = I2.Dipartimento
    )
GROUP BY I.Dipartimento;
```

***

## **ESEMPIO 3 (vincoli)** 

* Definire sulla tabella Impiegato il vincolo che il dipartimento Amministrazione abbia meno di 100 dipendenti, con uno stipendio medio superiore ai 40 mila €

```sql
CHECK (100>= (
    SELECT COUNT(*)
    FROM Impiegato
    WHERE Dipartimento ="Amministrazione")
AND 40000 <= (SELECT AVG(Stipendio)
              FROM Impiegato
              WHERE Dipartiemnto ="Amministrazione")
);
```