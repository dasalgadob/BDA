-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema dw_delitos
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema dw_delitos
-- -----------------------------------------------------
DROP SCHEMA `dw_delitos`;
CREATE SCHEMA IF NOT EXISTS `dw_delitos`;
USE `dw_delitos` ;

-- -----------------------------------------------------
-- Table `dw_delitos`.`d_date`
-- -----------------------------------------------------
drop table  `dw_delitos`.`d_date`;
CREATE TABLE IF NOT EXISTS `dw_delitos`.`d_date` (
  `first_date` DATETIME NULL DEFAULT NULL,
  `day_in_dimension` INT(11) NULL DEFAULT NULL,
  `dimension_date` DATETIME NULL DEFAULT NULL,
  `id_date` DOUBLE NOT NULL,
  `year` DOUBLE NULL DEFAULT NULL,
  `quarter` DOUBLE NULL DEFAULT NULL,
  `month` DOUBLE NULL DEFAULT NULL,
  `day` DOUBLE NULL DEFAULT NULL,
  `weekday` DOUBLE NULL DEFAULT NULL,
  `month_name` TINYTEXT NULL DEFAULT NULL,
  `month_abbreviation` TINYTEXT NULL DEFAULT NULL,
  `day_name` TINYTEXT NULL DEFAULT NULL,
  `day_abbreviation` TINYTEXT NULL DEFAULT NULL,
  `year_in_dimension` DOUBLE NULL DEFAULT NULL,
  `quarters_in_dimension` DOUBLE NULL DEFAULT NULL,
  `month_in_dimension` DOUBLE NULL DEFAULT NULL,
  `day_in_year` DOUBLE NULL DEFAULT NULL,
  PRIMARY KEY (`id_date`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dw_delitos`.`dim_denunciante`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dw_delitos`.`dim_denunciante` (
  `id_denunciante` INT NOT NULL AUTO_INCREMENT,
  `edad` INT NULL,
  `movilizacion` VARCHAR(45) NULL,
  `sexo` VARCHAR(45) NULL,
  `estado_civil` VARCHAR(45) NULL,
  `pais_nacimiento` VARCHAR(45) NULL,
  `clase_empleado` VARCHAR(45) NULL,
  `escolaridad` VARCHAR(45) NULL,
  `ocupacion` VARCHAR(45) NULL,
  PRIMARY KEY (`id_denunciante`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dw_delitos`.`dim_objeto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dw_delitos`.`dim_objeto` (
  `id_objeto` INT NOT NULL AUTO_INCREMENT,
  `clase` VARCHAR(45) NULL,
  `marca` VARCHAR(45) NULL,
  `linea` VARCHAR(45) NULL,
  `modelo` VARCHAR(45) NULL,
  `color` VARCHAR(45) NULL,
  PRIMARY KEY (`id_objeto`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dw_delitos`.`dim_geografia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dw_delitos`.`dim_geografia` (
  `id_geografia` INT NOT NULL AUTO_INCREMENT,
  `departamento` VARCHAR(45) NULL,
  `zona` VARCHAR(45) NULL,
  `municipio` VARCHAR(45) NULL,
  `barrio` VARCHAR(45) NULL,
  `localidad` VARCHAR(45) NULL,
  PRIMARY KEY (`id_geografia`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `dw_delitos`.`hecho_delito`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dw_delitos`.`hecho_delito` (
  `id_delito` INT NOT NULL AUTO_INCREMENT,
  `arma_empleada` VARCHAR(45) NULL,
  `movilidad_del_agresor` VARCHAR(45) NULL,
  `clase_sitio` VARCHAR(45) NULL,
  `cantidad` INT NULL,
  `id_denunciante` INT NOT NULL,
  `id_objeto` INT NOT NULL,
  `id_geografia` INT NOT NULL,
  `id_date` DOUBLE NOT NULL,
  PRIMARY KEY (`id_delito`),
  INDEX `fk_hecho_delito_dim_denunciante_idx` (`id_denunciante` ASC),
  INDEX `fk_hecho_delito_dim_objeto1_idx` (`id_objeto` ASC),
  INDEX `fk_hecho_delito_dim_geografia1_idx` (`id_geografia` ASC),
  INDEX `fk_hecho_delito_d_date1_idx` (`id_date` ASC),
  CONSTRAINT `fk_hecho_delito_dim_denunciante`
    FOREIGN KEY (`id_denunciante`)
    REFERENCES `dw_delitos`.`dim_denunciante` (`id_denunciante`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_hecho_delito_dim_objeto1`
    FOREIGN KEY (`id_objeto`)
    REFERENCES `dw_delitos`.`dim_objeto` (`id_objeto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_hecho_delito_dim_geografia1`
    FOREIGN KEY (`id_geografia`)
    REFERENCES `dw_delitos`.`dim_geografia` (`id_geografia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_hecho_delito_d_date1`
    FOREIGN KEY (`id_date`)
    REFERENCES `dw_delitos`.`d_date` (`id_date`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
