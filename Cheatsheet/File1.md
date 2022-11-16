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
* La condizione di JOIN va nella clausola WHERE. Se una colonna appare in più di una tabella, specifico a quale mi sto riferendo con un prefisso del nome della tabella corrispondente.

```sql

```