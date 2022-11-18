CREATE TABLE `mylibrary`.`staff` 
(`empID` INT(4) NOT NULL , 
`SurnameName` VARCHAR(35) NOT NULL , 
`Pay` INT(10) NULL , 
`FreeDay` VARCHAR(3) NULL , 
PRIMARY KEY (`empID`)) 
ENGINE = InnoDB; 

----

CREATE TABLE `mylibrary`.`author` 
(`AuthorNameSurname` VARCHAR(35) NOT NULL , 
`NumBooksWritten` INT(10) NULL , 
`Location` VARCHAR(30) NULL , 
`email` VARCHAR(50) NULL , 
PRIMARY KEY (`AuthorNameSurname`)) 
ENGINE = InnoDB; 

-----

CREATE TABLE `mylibrary`.`LibraryStorage` 
(`SectionID` INT(4) NOT NULL,
`Building` VARCHAR(10) NOT NULL, 
 `Curator` INT(4) NOT NULL, 
 `CopiesPerSection` INT(10) NULL,
FOREIGN KEY (`Curator`) REFERENCES `staff`(`empID`),
PRIMARY KEY (`SectionID`)
)
ENGINE = InnoDB;

------

CREATE TABLE `mylibrary`.`BookIdeal` 
(`BookID` INT(10) NOT NULL, 
 `Title` VARCHAR(30) NOT NULL, 
 `Author` VARCHAR(35) NOT NULL, 
 `Genre` VARCHAR(20) NULL,
 PRIMARY KEY (`BookID`),
 FOREIGN KEY (`Author`) REFERENCES `author`(`AuthorNameSurname`)
)
ENGINE = InnoDB;

-----

CREATE TABLE `mylibrary`.`ActualBookCopy`(
`ID_Physical` INT(8) NOT NULL,
`CopiesInStock` INT(10) NULL,
`SectionNum` INT(4) NOT NULL,
`ID_Ideal` INT(10) NOT NULL,
`Price` INT(8) NULL,
FOREIGN KEY (`ID_Ideal`) REFERENCES `bookideal`(`BookID`),
FOREIGN KEY (`SectionNum`) REFERENCES `librarystorage`(`SectionID`),
PRIMARY KEY (`ID_Physical`)
)
ENGINE = InnoDB;

-------

CREATE TABLE `mylibrary`.`Transaction` (
`ID_Transaction_Single` INT(12) NOT NULL,
`BookBoughtPhysicalID` INT(8) NOT NULL,
`SoldByEmployee` INT(4) NOT NULL,
`ID_Multiple_Purchase` INT(8) NOT NULL,
`Price` INT(8) NULL,
PRIMARY KEY (`ID_Transaction_Single`),
FOREIGN KEY (`SoldByEmployee`) REFERENCES `staff`(`empID`)
)
ENGINE = InnoDB;

---------

INSERT INTO `staff` (`empID`, `SurnameName`, `Pay`, `FreeDay`) VALUES ('0001', 'ELIZABETH, SMITH', '1000', 'THU');
INSERT INTO `staff` (`empID`, `SurnameName`, `Pay`, `FreeDay`) VALUES ('0002', 'ALICE, JOHNSON', '800', 'TUE');
INSERT INTO `staff` (`empID`, `SurnameName`, `Pay`, `FreeDay`) VALUES ('0003', 'NANCY, GRAYSON', '700', 'WED');
INSERT INTO `staff` (`empID`, `SurnameName`, `Pay`, `FreeDay`) VALUES ('0004', 'JOHN, SMITH', '600', 'MON');
INSERT INTO `staff` (`empID`, `SurnameName`, `Pay`, `FreeDay`) VALUES ('0005', 'ELIZABETH, LONGCASTLE', '1000', 'SAT');
INSERT INTO `staff` (`empID`, `SurnameName`, `Pay`, `FreeDay`) VALUES ('0006', 'MARY, LAMB', '700', 'WED');

----------

INSERT INTO `author`(`AuthorNameSurname`, `Location`) VALUES ('MARY SHELLEY', 'ENGLAND');
INSERT INTO `author` (`AuthorNameSurname`, `Location`,`email`) VALUES ('TATSUKI FUJIMOTO', 'JAPAN', 'tatsfuji@jap.com');
INSERT INTO `author` (`AuthorNameSurname`, `Location`) VALUES ('RENE GIRARD', 'FRANCE');
INSERT INTO `author` (`AuthorNameSurname`, `Location`, `email`) VALUES ('VIRGINIA WOOLF', 'ENGLAND', 'awooolf@eng.com');
INSERT INTO `author` (`AuthorNameSurname`, `Location`) VALUES ('ERODOTO', 'GREECE');
INSERT INTO `author` (`AuthorNameSurname`, `Location`) VALUES ('DONNA TARTT', 'USA');


