-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema sakila
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema dw_sakila
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `dw_sakila` ;

-- -----------------------------------------------------
-- Schema dw_sakila
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `dw_sakila` DEFAULT CHARACTER SET latin1 ;
USE `dw_sakila` ;

-- -----------------------------------------------------
-- Table `dw_sakila`.`dim_customer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dw_sakila`.`dim_customer` ;

CREATE TABLE IF NOT EXISTS `dw_sakila`.`dim_customer` (
  `customer_id` INT(11) NOT NULL,
  `store_id` INT(11) NOT NULL,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NULL,
  `active` VARCHAR(45) NULL,
  `create_date` DATE NULL,
  `last_update` DATE NULL,
  `city` VARCHAR(45) NULL,
  `country` VARCHAR(45) NULL,
  `address` VARCHAR(45) NULL,
  `postal_code` VARCHAR(45) NULL,
  PRIMARY KEY (`customer_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `dw_sakila`.`dim_date`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dw_sakila`.`dim_date` ;

CREATE TABLE IF NOT EXISTS `dw_sakila`.`dim_date` (
  `date_id` INT NOT NULL AUTO_INCREMENT,
  `date_year` VARCHAR(45) NULL,
  `date_month` VARCHAR(45) NULL,
  `date_day` VARCHAR(45) NULL,
  PRIMARY KEY (`date_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dw_sakila`.`dim_film`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dw_sakila`.`dim_film` ;

CREATE TABLE IF NOT EXISTS `dw_sakila`.`dim_film` (
  `film_id` INT NOT NULL,
  `title` VARCHAR(45) NULL,
  `description` TEXT(3000) NULL,
  `release_year` VARCHAR(45) NULL,
  `languaje` VARCHAR(45) NULL,
  `original_languaje` VARCHAR(45) NULL,
  `rental_duration` VARCHAR(45) NULL,
  `rental_rate` VARCHAR(45) NULL,
  `lenght` VARCHAR(45) NULL,
  `remplacement_cost` VARCHAR(45) NULL,
  `rating` VARCHAR(45) NULL,
  `special_features` TEXT(3000) NULL,
  PRIMARY KEY (`film_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dw_sakila`.`dim_store`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dw_sakila`.`dim_store` ;

CREATE TABLE IF NOT EXISTS `dw_sakila`.`dim_store` (
  `store_id` INT NOT NULL,
  `address` VARCHAR(45) NULL,
  `city` VARCHAR(45) NULL,
  `country` VARCHAR(45) NULL,
  `potal_code` VARCHAR(45) NULL,
  PRIMARY KEY (`store_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dw_sakila`.`dim_staff`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dw_sakila`.`dim_staff` ;

CREATE TABLE IF NOT EXISTS `dw_sakila`.`dim_staff` (
  `staff_id` INT NOT NULL,
  `first_name` VARCHAR(45) NULL,
  `last_name` VARCHAR(45) NULL,
  `address` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `active` VARCHAR(45) NULL,
  `username` VARCHAR(45) NULL,
  PRIMARY KEY (`staff_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dw_sakila`.`fact_rental`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dw_sakila`.`fact_rental` ;

CREATE TABLE IF NOT EXISTS `dw_sakila`.`fact_rental` (
  `rental_id` INT NOT NULL,
  `dim_date_id` INT NOT NULL,
  `dim_film_film_id` INT NOT NULL,
  `dim_store_store_id` INT NOT NULL,
  `dim_staff_staff_id` INT NOT NULL,
  `dim_customer_customer_id` INT(11) NOT NULL,
  `dim_staff_manager` INT NOT NULL,
  `rental_date` VARCHAR(45) NULL,
  `return_date` VARCHAR(45) NULL,
  PRIMARY KEY (`rental_id`),
  INDEX `fk_fact_renta_pelicula_dim_time1_idx` (`dim_date_id` ASC) VISIBLE,
  INDEX `fk_fact_renta_pelicula_dim_film1_idx` (`dim_film_film_id` ASC) VISIBLE,
  INDEX `fk_fact_renta_pelicula_dim_store1_idx` (`dim_store_store_id` ASC) VISIBLE,
  INDEX `fk_fact_renta_pelicula_dim_staff1_idx` (`dim_staff_staff_id` ASC) VISIBLE,
  INDEX `fk_fact_renta_pelicula_dim_customer1_idx` (`dim_customer_customer_id` ASC) VISIBLE,
  INDEX `fk_fact_renta_pelicula_dim_staff2_idx` (`dim_staff_manager` ASC) VISIBLE,
  CONSTRAINT `fk_fact_renta_pelicula_dim_time1`
    FOREIGN KEY (`dim_date_id`)
    REFERENCES `dw_sakila`.`dim_date` (`date_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fact_renta_pelicula_dim_film1`
    FOREIGN KEY (`dim_film_film_id`)
    REFERENCES `dw_sakila`.`dim_film` (`film_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fact_renta_pelicula_dim_store1`
    FOREIGN KEY (`dim_store_store_id`)
    REFERENCES `dw_sakila`.`dim_store` (`store_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fact_renta_pelicula_dim_staff1`
    FOREIGN KEY (`dim_staff_staff_id`)
    REFERENCES `dw_sakila`.`dim_staff` (`staff_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fact_renta_pelicula_dim_customer1`
    FOREIGN KEY (`dim_customer_customer_id`)
    REFERENCES `dw_sakila`.`dim_customer` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fact_renta_pelicula_dim_staff2`
    FOREIGN KEY (`dim_staff_manager`)
    REFERENCES `dw_sakila`.`dim_staff` (`staff_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dw_sakila`.`fact_inventory`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `dw_sakila`.`fact_inventory` ;

CREATE TABLE IF NOT EXISTS `dw_sakila`.`fact_inventory` (
  `inventory_id` VARCHAR(45) NOT NULL,
  `dim_film_film_id` INT NOT NULL,
  `dim_store_store_id` INT NOT NULL,
  PRIMARY KEY (`inventory_id`),
  INDEX `fk_fact_inventory_dim_store1_idx` (`dim_store_store_id` ASC) VISIBLE,
  CONSTRAINT `fk_fact_inventory_dim_film1`
    FOREIGN KEY (`dim_film_film_id`)
    REFERENCES `dw_sakila`.`dim_film` (`film_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fact_inventory_dim_store1`
    FOREIGN KEY (`dim_store_store_id`)
    REFERENCES `dw_sakila`.`dim_store` (`store_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
