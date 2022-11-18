# **SELECT**

***

**INDICE**: ☝️

- [**SELECT**](#select)
  - [**SELECT: BASICS**](#select-basics)
  - [**Predicati di confronto**](#predicati-di-confronto)
  - [**Operatori Logici**](#operatori-logici)
  - [**Clausola ORDER BY**](#clausola-order-by)
  - [**JOIN**](#join)
  - [**Natural Join**](#natural-join)
  - [**Prodotto Cartesiano**](#prodotto-cartesiano)
  - [**Join Esplicito - (JOIN ... ON ...)**](#join-esplicito---join--on-)
  - [**JOINS**](#joins)
    - [**LEFT JOIN**](#left-join)
    - [**FULL JOIN**](#full-join)
    - [**UNION JOIN**](#union-join)
  - [**UNIONE (vera e propria)**](#unione-vera-e-propria)
  - [**OPERATORI AGGREGATI**](#operatori-aggregati)
    - [**Esempi di uso operatori aggregati SUM() AVG() MAX() MIN()**](#esempi-di-uso-operatori-aggregati-sum-avg-max-min)
    - [**COUNT**](#count)
  - [**GROUP BY**](#group-by)
  - [**HAVING**](#having)
  - [**QUERY NIDIFICATE**](#query-nidificate)
    - [**Comportamento dei valori NULL nelle sottoselect**](#comportamento-dei-valori-null-nelle-sottoselect)
    - [**Confronto tra attributo e sottoselect**](#confronto-tra-attributo-e-sottoselect)
      - [**Clausola ANY**](#clausola-any)
      - [**Clausola ALL**](#clausola-all)
      - [**Attributo [NOT] IN (SOTTOSELECT)**](#attributo-not-in-sottoselect)
    - [**QUANTIFICATORE ESISTENZIALE**](#quantificatore-esistenziale)
    - [**Esempi di sottoqueries nidificate**](#esempi-di-sottoqueries-nidificate)
    - [**Quantificatore Universale / Quoziente**](#quantificatore-universale--quoziente)

***

## **SELECT: BASICS**

```sql
SELECT [DISTINCT] Lista_Attributi_O_Espressioni
FROM Lista_Tabelle
[WHERE Condizioni_Semplici]
[GROUP BY Lista_Attributi_Di_Raggruppamento]
[HAVING Condizioni_Aggregate]
[ORDER BY Lista_Attributi_Di_Ordinamento]
```

- E' possibile usare gli operatori aritmetici nella TargetList (Select)
- E' possibile **rinominare una colonna** utilizzando "**AS**". Ciò è anche utile per prevenire casi di conflitto a causa di omonimie.
  - ```SELECT ename AS name```
  - ```SELECT sal salary```
- Specificando **DISTINCT**, i record uguali vengono mostrati una sola volta.
- nella **WHERE** applico i predicati di confronto.

***

## **Predicati di confronto**

- Confronto "classico" --> ```<, >, <=, >=, =, <>```

- ```BETWEEN ...  AND  ...``` --> Compreso tra due valori

```sql
SELECT ename, sal
FROM emp
WHERE sal BETWEEN 1000 AND 1500;
```

- ```IN (list)``` --> corrispondente a uno dei valori della lista.

```sql
SELECT empno, ename, sal, mgr
FROM emp
WHERE mgr IN (3834, 2814, 4389);
```

- ```LIKE``` --> Operatore di pattern matching, sorta di REGEX. Può essere combinato.
  - ```%``` denota zero o più caratteri
  - ```_``` denota un carattere

```sql
SELECT ename
FROM emp
WHERE ename LIKE '%S'; 
```

- ```IS NULL``` --> Valore nullo.
  - ```Espr IS [NOT] NULL```

```sql
SELECT Nome
FROM Studenti
WHERE Telefono IS NOT NULL; 
```

***

## **Operatori Logici**

- i "classici" ```NOT, AND, OR```, in precedenza come elencati

***

## **Clausola ORDER BY**
  
- Ordina le righe.  
  - **ASC**: in ordine crescente, default.  
  - **DESC**: in ordine decrescente.  

- E' possibile ordinare tramite alias
- E' possibile ordinare l'ordinamento specificando due attributi

```sql
SELECT ename, deptno, sal
FROM emp
ORDER BY deptno, sal DESC; 
```

***

## **JOIN**

- Viene utilizzata per fare queries su più tabelle.
- **La condizione di JOIN va nella clausola WHERE**. Se una colonna appare in più di una tabella, specifico a quale mi sto riferendo con un prefisso del nome della tabella corrispondente.

Sintassi:
  
```sql
SELECT t1.colonna, t2.colonna
FROM t1, t2
WHERE t1.colonna1 = t2.colonna2
```

Esempio:
  
```sql
SELECT Professore, Corsi.Corso
FROM Corsi, Esami, Studenti
WHERE Corsi.Corso = Esami.Corso 
AND Esami.Matricola = Studenti.Matricola
AND Nome = 'Teo Verdi' 
AND Voto > 24
```

***

## **Natural Join**

- Quando la prima tabella e la seconda tabella hanno un attributo in comune

Es:
  
```sql
SELECT emp.empno,   emp.ename, emp.deptno, dept.deptno, dept.loc
FROM   emp, dept
WHERE  emp.deptno=dept.deptno;
```

```sql
SELECT Studenti.Nome, Esami.Corso, Esami.Voto
FROM Esami NATURAL JOIN Studenti
```

***

## **Prodotto Cartesiano**

```CROSS JOIN```

- E' ottenuto quando
  - Es: la prima tabella è di 13 righe e la seconda di 5. Allora la tabella della query viene di 13*5 colonne.
  - Una condizione Join è omessa --> Inserire condizioni Joins valide nella clausola WHERE!
  - Tutte le righe della prima tabella ammettono joins con tutte le righe della seconda

***

## **Join Esplicito - (JOIN ... ON ...)**

Esempio di query uguali con due sintassi diverse (una con l'utilizzo della clausola WHERE e l'altra col JOIN ON):

**Sintassi**:

```sql
SELECT ...
FROM  Tabella {... JOIN Tabella ON CondizioneDiJoin }
[WHERE AltraCondizione]
```

> **Query**: Padre e madre di ogni persona

Con WHERE:

```sql
SELECT paternita.figlio, padre, madre
FROM maternita, paternita
WHERE paternita.figlio = maternita.figlio
```

Con JOIN:

```sql
SELECT madre, paternita.figlio, padre
FROM maternita JOIN paternita 
ON paternita.figlio = maternita.figlio
```

//...

> **Query**: "I padri che guadagnano più di 20

```sql
SELECT DISTINCT padre
FROM persone, paternita
WHERE figlio = nome AND reddito >20
```

```sql
SELECT DISTINCT padre
FROM persone 
JOIN paternita ON figlio = nome
WHERE reddito >20
```

***

## **JOINS**

```JOIN ... USING ...```

- La **Natural Join** sugli attributi specificati nella clausola USING (un sottoinsieme di quelli **in comune**) presenti in entrambe le tabelle

```JOIN ... ON ...```

- Una Join su quelli **che soddisfano una certa condizione**

```LEFT JOIN / RIGHT JOIN / FULL JOIN```

- Usato con Natural Join o Join, è la giunzione esterna nelle tre modalità

### **LEFT JOIN**

```sql
SELECT paternita.figlio, padre, madre
FROM paternita LEFT JOIN maternita ON paternita.figlio = maternita.figlio
```

> **Query**: Codice agente ed ammontare degli agenti incluso quelli che non hanno effettuato ordini (avranno ammontare NULL)

```sql
SELECT Agenti.CodiceAgente, Ordini.Ammontare
FROM Agenti NATURAL LEFT JOIN Ordini
```

### **FULL JOIN**

```sql
SELECT paternita.figlio, padre, madre
FROM maternita FULL JOIN paternita
ON maternita.figlio = paternita.figlio
```

### **UNION JOIN**

- E' l'**unione esterna**, ovvero quando le due tabelle si estendono con le colonne dell'altro in valori nulli; una unione

***

## **UNIONE (vera e propria)**

- I duplicati vengono eliminati: per mantenerli, specificare ```UNION ALL```
- Esistono anche ```INTERSECT [ALL]``` e ```EXCEPT [ALL]```  

Sintassi:  

```sql

SELECT
... 
UNION
... 
SELECT

```

- Attenzione alla **notazione posizionale**.
- Corretto uso della UNION:

```sql
SELECT padre AS genitore, figlio
FROM paternita
UNION
SELECT madre as genitore, figlio
FROM maternita
```

***

## **OPERATORI AGGREGATI**

- E' possibile metterli solo nella TargetList
- Non sono rappresentabili in algebra relazionale
- **AVG()**, **COUNT()**, **MAX()**, **MIN()**, **SUM()**
- Tutti tranne **COUNT()** Possono essere usati su dati numerici.
- **MIN()** e **MAX()** su dati di qualsiasi tipo.
- Se una colonna contiene solo valori nulli, **MIN()**, **MAX()**, **AVG()**, **SUM()** Restituiscono NULL, mentre **COUNT()** restituisce zero.
- **AVG()** e **SUM()** ignorano i valori nulli.

### **Esempi di uso operatori aggregati SUM() AVG() MAX() MIN()**

```sql
SELECT AVG(reddito)
FROM persone
WHERE eta <30
```

```sql
SELECT AVG(reddito)
FROM persone JOIN paternita ON nome=figlio
WHERE padre='FRANCO'
```

```sql
SELECT AVG(reddito), MIN(reddito), MAX(reddito)
FROM persone
WHERE eta <30
```

***

### **COUNT**

- **COUNT()** ritorna il numero di righe di una tabella.
- ```SELECT COUNT(*) FROM persone``` Ritorna il numero di tuple.
- ```SELECT COUNT(reddito) FROM persone``` Ritorna il numero di volte in cui "Reddito" non sia NULL
- ```SELECT COUNT(DISTINCT Reddito) FROM persone``` Numero di valori DISTINTI del campo reddito (che non siano NULL), ovvero tipo le classi di equivalenza dei redditi, le tiers di redditi possibili

***

## **GROUP BY**

- Divide le righe in gruppi più piccoli
- **Importante**: tutte le colonne della SELECT che non sono in funzioni di gruppo **DEVONO ESSERE NELLA GROUP BY**
- La colonna per cui raggruppo non dev'essere necessariamente nella SELECT

- Posso raggruppare per più di un attributo
  - ```SELECT deptno, job, sum(sal)```
  - ```FROM emp```
  - ```GROUP BY deptno, job;```

**Sintassi**:

```sql
SELECT column, group_function(column)
FROM tables
[WHERE etc]
GROUP BY group_by_expression 
```

**Esempio**:  

```sql
SELECT Padre, COUNT(*) AS NumFigli
FROM paternita
GROUP BY Padre
```

***

## **HAVING**

- Per restringere gruppi. Le righe sono raggruppate e possiamo utilizzare operatori aggregati.
- Ammette una **Espressione BOOLEANA** (es: risultati di confronto)

**Esempi**:
  
```sql
SELECT deptno, MAX(sal)
FROM emp
GROUP BY deptNo
HAVING MAX(sal)>2900
```

```sql
SELECT job, SUM(sal) as Payroll
FROM emp
WHERE job NOT LIKE 'SALES%'
HAVING SUM(sal)>5000
ORDER BY SUM(sal);
```

***

.  
.  
|**Fine primo powerpoint e inizio secondo**|  
.  
.  

***

## **QUERY NIDIFICATE**

- Meno dichiarative ma più facilmente interpretabili: Suddivise in blocchi
  - Tuttavia, query nidificate più complesse possono essere di difficile comprensione.
- Può essere combinata con la forma piana
- Le sottoquery **NON POSSONO contenere operatori insiemistici**, "l'unione si fa solo al livello esterno".
- Non è possibile fare riferimento a variabili fuori scope (in blocchi più interni, come gli altri linguaggi)

- La Query interna può usare variabili della query esterna
- La Query interna viene eseguita una volta per ciascun record della query esterna

```sql

-- STUDENTI CHE HANNO UN OMONIMO
SELECT *
FROM Student S
WHERE EXISTS (SELECT *
    FROM Student S2
    WHERE S2.Nome = S.Nome
    AND   S2.Cognome = S.Cognome
    AND   S2.Matricola <> S.Matricola
    )

--- VS ---

-- STUDENTI CHE *NON* HANNO UN OMONIMO 
SELECT *
FROM Student S
WHERE NOT EXISTS (SELECT *
    FROM  Student S2
    WHERE S2.Nome = S.Nome
    AND   S2.Cognome = S.Cognome
    AND   S2.Matricola <> S.Matricola
    )

```

***

### **Comportamento dei valori NULL nelle sottoselect**

- ```Espr. [operaz.] (Sottoselect)```
  - Vale unknown SE
    - espr. è NULL
    - la sottoselect produce una tabella/insieme vuoti

- ```Espr. IN (Sottoselect)```
- ```Espr. [op] ANY (Sottoselect)```
  - Valgono unknown SE
    - Espr. è NULL
    - se NULL è fra i valori della Sottoselect e il predicato è falso per i NOT NULL.

- ```Espr. [op] ALL (Sottoselect)```
  - Vale Unknown SE
    - Espr. è NULL
    - se NULL è fra i valori della Sottoselect

***

### **Confronto tra attributo e sottoselect**

- ```attributo <= / >= / <> / = / < / > (Sottoselect)```
- La sottoselect deve restituire una tabella **con un solo elemento o vuota**

#### **Clausola ANY**

Il predicato è vero se **almeno uno dei valori** restituiti dalla query soddisfano la condizione

#### **Clausola ALL**

Il predicato è vero se **tutti i valori** restituiti dalla query soddisfano la condizione

```Attributo [operaz.] [ANY|ALL] (SOTTOSELECT)```

#### **Attributo [NOT] IN (SOTTOSELECT)**

(as it says on the tin)

***

### **QUANTIFICATORE ESISTENZIALE**

```EXISTS```

Il predicato è vero se la sottoselect restituisce **ALMENO UNA TUPLA**

```NOT EXISTS```

Il predicato è vero se la sottoselect **non restituisce tuple**, ovvero se restituisce **l'insieme vuoto**.

Esempio:  

```sql
SELECT *
FROM persone
WHERE EXISTS( SELECT *
      FROM Paternita
      WHERE Padre = Nome)
  OR
  EXISTS ( SELECT *
      FROM Maternita
      WHERE Madre = Nome)
```

***

### **Esempi di sottoqueries nidificate**
  
***Es**: tre query "sinonime"*
  
```sql
SELECT P.Nome, P.Reddito
FROM Persone P, Paternita, Persone F
WHERE P.Nome = Padre 
AND Figlio = F.Nome
AND F.Reddito > 20

SELECT Nome, Reddito
FROM Persone
WHERE Nome in (SELECT Padre
      FROM Paternita
      WHERE Figlio = any (SELECT Nome
            FROM Persone
            WHERE Reddito > 20
            )
      )

SELECT Nome, Reddito
FROM Persone
WHERE Nome in ( SELECT Padre
      FROM Paternita, Persone
      WHERE Figlio = Nome
      AND Reddito > 20
)

```

***

### **Quantificatore Universale / Quoziente**

```SQL
Agenti(CodiceAgente, Nome, Zona, Supervisore, Commissione);
Clienti(CodiceCliente, Nome, Citta, Sconto);
Ordini(CodiceOrdine, CodiceCliente, CodiceAgente, Articolo, Data, Ammontare);
```

Esempio:

- Trova tutti i clienti che hanno fatto ordini a TUTTI gli agenti di Catania  
  - Implica che per ogni agente Z di Catania esiste un ordine Y del cliente X fatto con Z.  
    - Per ogni agente Z esiste cliente Y, con Y(n, x, z, p, d, a)
  - Il che è equivalente a dire che non esista un agente Z tale che cliente Y non abbia fatto un ordine con tale agente Z.  
    - Non esiste Z per il quale non esiste Y, con Y (n, x, z, p, d, a)

```sql
SELECT C.CodiceCliente
FROM Clienti C
WHERE NOT EXISTS ( SELECT * 
      FROM Agenti A
      WHERE A.Zona = 'Catania'
      AND NOT EXISTS( SELECT *
            FROM Ordini V
            WHERE V.CodiceCliente = C.CodiceCliente
            AND V.CodiceCliente = A.CodiceAgente
            )
      )
```
