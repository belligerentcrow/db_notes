# **CHEATSHEET - DB**

## **SELECT**

```sql
SELECT [DISTINCT] attributi
FROM Tabelle
[WHERE condizione]
```

* E' possibile usare gli operatori aritmetici nella TargetList (Select)
* E' possibile **rinominare una colonna** utilizzando "**AS**". Ciò è anche utile per prevenire casi di conflitto a causa di omonimie. 
  * ```SELECT ename AS name```
  * ```SELECT sal salary```
* Specificando **DISTINCT**, i record uguali vengono mostrati una sola volta.
* nella **WHERE** applico i predicati di confronto.

***

## **Predicati di confronto**

* Confronto "classico" --> ```<, >, <=, >=, =, <>```

* ```BETWEEN ...  AND  ...``` --> Compreso tra due valori

```sql
SELECT ename, sal
FROM emp
WHERE sal BETWEEN 1000 AND 1500;
```

* ```IN (list)``` --> corrispondente a uno dei valori della lista. 

```sql
SELECT empno, ename, sal, mgr
FROM emp
WHERE mgr IN (3834, 2814, 4389);
```

* ```LIKE``` --> Operatore di pattern matching, sorta di REGEX. Può essere combinato.
  * ```%``` denota zero o più caratteri
  * ```_``` denota un carattere

```sql
SELECT ename
FROM emp
WHERE ename LIKE '%S'; 
```

* ```IS NULL``` --> Valore nullo.
  * ```Espr IS [NOT] NULL```

```sql
SELECT Nome
FROM Studenti
WHERE Telefono IS NOT NULL; 
```

***

## **Operatori Logici** 

* i "classici" ```NOT, AND, OR```, in precedenza come elencati

***

## **Clausola ORDER BY**
  
* Ordina le righe.  
  * **ASC**: in ordine crescente, default.  
  * **DESC**: in ordine decrescente.  

* E' possibile ordinare tramite alias
* E' possibile ordinare l'ordinamento specificando due attributi

```sql
SELECT ename, deptno, sal
FROM emp
ORDER BY deptno, sal DESC; 
```

***

## **JOIN**

* Viene utilizzata per fare queries su più tabelle.
* **La condizione di JOIN va nella clausola WHERE**. Se una colonna appare in più di una tabella, specifico a quale mi sto riferendo con un prefisso del nome della tabella corrispondente.

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

* Quando la prima tabella e la seconda tabella hanno un attributo in comune

Es:
  
```sql
SELECT emp.empno,   emp.ename, emp.deptno, dept.deptno, dept.loc
FROM   emp, dept
WHERE  emp.deptno=dept.deptno;
```

***

## **Prodotto Cartesiano**

* E' ottenuto quando
  * Es: la prima tabella è di 13 righe e la seconda di 5. Allora la tabella della query viene di 13*5 colonne. 
  * Una condizione Join è omessa --> Inserire condizioni Joins valide nella clausola WHERE! 
  * Tutte le righe della prima tabella ammettono joins con tutte le righe della seconda

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
SELECT

```