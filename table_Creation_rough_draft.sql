-- Create the vetClinic Database

DROP DATABASE IF EXISTS vetClinic;
CREATE DATABASE vetClinic;
USE vetClinic;

-- Create Tables

CREATE TABLE IF NOT EXISTS `vetClinic`.`Clinic` (
  `CLINIC_NUM` INT NOT NULL AUTO_INCREMENT,
  `CLINIC_ADDRESS` VARCHAR(255) NOT NULL,
  `CLINIC_CITY` VARCHAR(50) NOT NULL,
  `CLINIC_STATE` CHAR(2) NOT NULL,
  `CLINIC_ZIP` VARCHAR(10) NOT NULL,
  `CLINIC_TEL` VARCHAR(10) NOT NULL,
  `CLINIC_FAX` VARCHAR(10) NOT NULL,
  `CLINIC_MANAGER` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`CLINIC_NUM`)
  );

CREATE TABLE IF NOT EXISTS `vetClinic`.`Pet_Owners` (
  `OWNER_ID` INT NOT NULL AUTO_INCREMENT,
  `CLINIC_NUM` INT NOT NULL,
  `OWNER_FNAME` VARCHAR(45) NOT NULL,
  `OWNER_LNAME` VARCHAR(45) NOT NULL,
  `OWNER_ADDRESS` VARCHAR(255) NOT NULL,
  `OWNER_CITY` VARCHAR(45) NOT NULL,
  `OWNER_STATE` CHAR(2) NOT NULL,
  `OWNER_ZIP` VARCHAR(10) NOT NULL,
  `OWNER_PHONE` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`OWNER_ID`),
  CONSTRAINT `CLINIC_NUM`
    FOREIGN KEY (`CLINIC_NUM`)
    REFERENCES `vetClinic`.`Clinic` (`CLINIC_NUM`)
);

CREATE TABLE IF NOT EXISTS `vetClinic`.`Pets` (
  `PET_ID` INT NOT NULL AUTO_INCREMENT,
  `OWNER_ID` INT NOT NULL,
  `PET_NAME` VARCHAR(45) NOT NULL,
  `PET_TYPE` VARCHAR(15) NOT NULL,
  `PET_DESCRIPTION` VARCHAR(255) NOT NULL,
  `PET_DOB` DATE NOT NULL,
  `REG_DATE` DATE NOT NULL,
  `PET_STATUS` ENUM('Alive', 'Deceased') NOT NULL,
  PRIMARY KEY (`PET_ID`),
  CONSTRAINT `OWNER_ID`
    FOREIGN KEY (`OWNER_ID`)
    REFERENCES `vetClinic`.`Pet_Owners` (`OWNER_ID`)
);

CREATE TABLE IF NOT EXISTS `vetClinic`.`Surgical and Non-Surgical Supplies` (
  `ITEM_NUMBER` INT NOT NULL AUTO_INCREMENT,
  `CLINIC_NUM` INT NOT NULL,
  `SUPPLY_NAME` VARCHAR(45) NOT NULL,
  `SUPPLY_DESC` VARCHAR(255) NOT NULL,
  `SUPPLY_QTY` INT NOT NULL,
  `REORDER_LVL` INT NOT NULL,
  `REORDER_QTY` INT NOT NULL,
  PRIMARY KEY (`ITEM_NUMBER`),
  CONSTRAINT `CLINIC_NUM`
    FOREIGN KEY (`CLINIC_NUM`)
    REFERENCES `vetClinic`.`Clinic` (`CLINIC_NUM`)
);

CREATE TABLE IF NOT EXISTS `vetClinic`.`Pharmacy` (
  `DRUG_NUM` INT NOT NULL AUTO_INCREMENT,
  `CLINIC_NUM` INT NOT NULL,
  `DRUG_NAME` VARCHAR(45) NOT NULL,
  `DRUG_DESC` VARCHAR(255) NOT NULL,
  `DRUG_DOSE` VARCHAR(255) NOT NULL,
  `ADMIN_METHOD` ENUM('Oral', 'Chewable', 'Injection', 'Drops', 'Subligimal') NOT NULL,
  `RX_COST` DECIMAL(8,2) NOT NULL,
  `DRUG_QTY` INT NOT NULL,
  `DRUG_REORDERLVL` INT NOT NULL,
  `DRUG_REORDERQTY` INT NOT NULL,
  PRIMARY KEY (`DRUG_NUM`),
  CONSTRAINT `CLINIC_NUM`
    FOREIGN KEY (`CLINIC_NUM`)
    REFERENCES `vetClinic`.`Clinic` (`CLINIC_NUM`)
);

CREATE TABLE IF NOT EXISTS `vetClinic`.`Staff` (
  `EMPLOYEE_ID` INT NOT NULL AUTO_INCREMENT,
  `CLINIC_NUM` INT NOT NULL,
  `FIRST_NAME` VARCHAR(50) NOT NULL,
  `LAST_NAME` VARCHAR(50) NOT NULL,
  `STAFF_STREET` VARCHAR(255) NOT NULL,
  `STAFF_CITY` VARCHAR(45) NOT NULL,
  `STAFF_STATE` CHAR(2) NOT NULL,
  `STAFF_ZIP` VARCHAR(10) NOT NULL,
  `STAFF_PHONE` VARCHAR(10) NOT NULL,
  `STAFF_DOB` DATE NOT NULL,
  `STAFF_GENDER` ENUM('male', 'female') NOT NULL,
  `STAFF_SSN` CHAR(9) NOT NULL,
  `POSITION` VARCHAR(45) NOT NULL,
  `SALARY` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`EMPLOYEE_ID`),
  CONSTRAINT `CLINIC_NUM`
    FOREIGN KEY (`CLINIC_NUM`)
    REFERENCES `vetClinic`.`Clinic` (`CLINIC_NUM`)
);

CREATE TABLE IF NOT EXISTS `vetClinic`.`Examinations` (
  `EXAM_NUM` INT NOT NULL AUTO_INCREMENT,
  `PET_ID` INT NOT NULL,
  `EMPLOYEE_ID` INT NOT NULL,
  `EXAM_TIME` TIME NOT NULL,
  `EXAM_DATE` DATE NOT NULL,
  `EXAM_COMMENTS` VARCHAR(250) NOT NULL,
  PRIMARY KEY (`EXAM_NUM`),
  CONSTRAINT `EMPLOYEE_ID`
    FOREIGN KEY (`EMPLOYEE_ID`)
    REFERENCES `vetClinic`.`Staff` (`EMPLOYEE_ID`)
);

CREATE TABLE IF NOT EXISTS `vetClinic`.`Pet Treatments` (
  `TREATMENT_ID` INT NOT NULL AUTO_INCREMENT,
  `EXAM_NUM` INT NOT NULL,
  `TREATMENT_BEGIN` DATE NOT NULL,
  `TREATMENT_END` DATE NOT NULL,
  `TREATMENT_QUANITY` INT NOT NULL,
  `TREATMENT_COMMENTS` VARCHAR(250) NULL,
  PRIMARY KEY (`TREATMENT_ID`),
  CONSTRAINT `EXAM_NUM`
    FOREIGN KEY (`EXAM_NUM`)
    REFERENCES `vetClinic`.`Examinations` (`EXAM_NUM`)
);

CREATE TABLE IF NOT EXISTS `vetClinic`.`Invoice` (
  `INVOICE_NUM` INT NOT NULL AUTO_INCREMENT,
  `INVOICE_DATE` DATE NOT NULL,
  `OWNER_ID` INT NOT NULL,
  `PET_ID` INT NOT NULL,
  `TREATMENT_ID` INT NOT NULL,
  `DATE_PAID` DATE NOT NULL,
  `PYMT_METHOD` ENUM('Cash', 'Check', 'Debit', 'Credit', 'Charged to Account') NOT NULL,
  `TOTAL_COST` DECIMAL(8,2) NOT NULL,
  PRIMARY KEY (`INVOICE_NUM`),
  CONSTRAINT `OWNER_ID`
    FOREIGN KEY (`OWNER_ID`)
    REFERENCES `vetClinic`.`Pet_Owners` (`OWNER_ID`),
  CONSTRAINT `PET_ID`
    FOREIGN KEY (`PET_ID`)
    REFERENCES `vetClinic`.`Pets` (`PET_ID`),
  CONSTRAINT `TREATMENT_ID`
    FOREIGN KEY (`TREATMENT_ID`)
    REFERENCES `vetClinic`.`Pet Treatments` (`TREATMENT_ID`)
);

CREATE TABLE IF NOT EXISTS `vetClinic`.`Pens` (
  `PEN_ID` INT NOT NULL AUTO_INCREMENT,
  `CLINIC_NUM` INT NOT NULL,
  `PEN_CAPACITY` INT NOT NULL,
  `PEN_STATUS` ENUM('Full', 'Available') NOT NULL,
  PRIMARY KEY (`PEN_ID`),
  CONSTRAINT `CLINIC_NUM`
    FOREIGN KEY (`CLINIC_NUM`)
    REFERENCES `vetClinic`.`Clinic` (`CLINIC_NUM`)
);

CREATE TABLE IF NOT EXISTS `vetClinic`.`Pet Pens` (
  `PEN_BOOKING` INT NOT NULL AUTO_INCREMENT,
  `PEN_ID` INT NOT NULL,
  `PET_ID` INT NOT NULL,
  `DATE_IN` DATE NOT NULL,
  `DATE_OUT` DATE NOT NULL,
  `PEN_COMMENTS` VARCHAR(250) NULL,
  PRIMARY KEY (`PEN_BOOKING`),
  CONSTRAINT `PEN_ID`
    FOREIGN KEY (`PEN_ID`)
    REFERENCES `vetClinic`.`Pens` (`PEN_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `PET_ID`
    FOREIGN KEY (`PET_ID`)
    REFERENCES `vetClinic`.`Pets` (`PET_ID`)
);