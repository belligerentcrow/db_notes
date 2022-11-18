CREATE TABLE `db_prova`.`employees` 
(`ID` INT(4) NOT NULL , 
`Name` VARCHAR(20) NOT NULL UNIQUE, 
`Role` VARCHAR(20) NOT NULL , 
`DeptNo` INT(4) NOT NULL UNIQUE, 
PRIMARY KEY (`ID`)) 
ENGINE = InnoDB; 

CREATE TABLE `db_prova`.`departments`(
`DepartmentNo` INT(4) NOT NULL PRIMARY KEY,
`DepName` VARCHAR(15) NOT NULL,
`Location` VARCHAR(25) NOT NULL,
`Supervisor` VARCHAR(20) NOT NULL)
ENGINE = InnoDB; 

ALTER TABLE `db_prova`.`employees`  
   ADD CONSTRAINT `FK1` 
      FOREIGN KEY (`DeptNo`) REFERENCES `departments`(`DepartmentNo`) 
      ON UPDATE RESTRICT 
      ON DELETE RESTRICT;
      
ALTER TABLE `db_prova`.`departments`  
   ADD CONSTRAINT `FK2` 
      FOREIGN KEY (`Supervisor`) REFERENCES `employees`(`Name`) 
      ON UPDATE RESTRICT 
      ON DELETE RESTRICT;

-------
INSERT INTO `employees` VALUES ('1241', 'WRIGHT', 'DEFENCE', '10');
INSERT INTO `departments` VALUES ('10', 'DEFENCE', 'JAPANIFORNIA', 'WRIGHT');
INSERT INTO `employees` VALUES ('4584', 'JUSTICE', 'DEFENCE', '10');
INSERT INTO `employees` VALUES ('1943', 'EDGEWORTH', 'PROSECUTION', '20');
INSERT INTO `employees` VALUES ('2524', 'VON KARMA, F', 'PROSECUTION', '20');
INSERT INTO `employees` VALUES ('0473', 'VON KARMA, m', 'PROSECUTION', '20');
------

ALTER TABLE `employees` ADD CONSTRAINT `fk1` FOREIGN KEY (`DeptNo`) REFERENCES `departments`(`DepartmentNo`) ON DELETE RESTRICT ON UPDATE RESTRICT; 

----


SELECT DISTINCT emp.Name 
FROM departments as dep JOIN employees as emp 
ON dep.DepartmentNo = emp.DeptNo 
WHERE emp.Name LIKE '%KARMA%' 
ORDER BY dep.DepartmentNo; 

------ 


INSERT INTO `employees` (`ID`, `Name`,`Role`,`DeptNo`) VALUES ('3245', 'GUMSHOE', 'DETECTIVE', '30');
INSERT INTO `employees` (`ID`, `Name`,`Role`,`DeptNo`) VALUES ('2013', 'SKYE, E', 'FORENSICS', '30');
INSERT INTO `employees` (`ID`, `Name`,`Role`,`DeptNo`) VALUES ('3985', 'SKYE, L', 'CHIEF PROSECUTOR', '20');
INSERT INTO `employees` (`ID`, `Name`,`Role`,`DeptNo`) VALUES ('5485', 'JUDGE1', 'JUDGE', '40');

SELECT emp.EmpNo, emp.EName, emp.DeptNo, dept.DeptNo, dept.Location
FROM employees AS emp, departments as dept
WHERE emp.DeptNo = dept.DeptNo;



