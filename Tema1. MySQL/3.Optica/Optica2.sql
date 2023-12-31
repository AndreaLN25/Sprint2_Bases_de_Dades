-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Optica_EER
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Optica_EER
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Optica_EER` DEFAULT CHARACTER SET utf8 ;
-- -----------------------------------------------------
-- Schema optica_eer
-- -----------------------------------------------------
USE `Optica_EER` ;

-- -----------------------------------------------------
-- Table `Optica_EER`.`Proveedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Optica_EER`.`Proveedor` (
  `Id_Proveedor` INT NOT NULL AUTO_INCREMENT,
  `Nombre_Proveedor` VARCHAR(45) NOT NULL,
  `Telefono_Proveedor` INT NOT NULL,
  `Fax_Proveedor` INT NULL,
  `NIF_Proveedor` VARCHAR(10) NOT NULL,
  `Dirección_Proveedor` VARCHAR(75) NOT NULL,
  PRIMARY KEY (`Id_Proveedor`),
  UNIQUE INDEX `NIF_Proveedor_UNIQUE` (`NIF_Proveedor` ASC) VISIBLE,
  UNIQUE INDEX `Nombre_Proveedor_UNIQUE` (`Nombre_Proveedor` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Optica_EER`.`Marca_Gafas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Optica_EER`.`Marca_Gafas` (
  `Id_Marca` INT NOT NULL AUTO_INCREMENT,
  `Nombre_Marca` VARCHAR(45) NOT NULL,
  `Proveedor_Id_Proveedor` INT NOT NULL,
  PRIMARY KEY (`Id_Marca`),
  UNIQUE INDEX `Id_Marca_UNIQUE` (`Id_Marca` ASC) VISIBLE,
  INDEX `fk_Marca_Gafas_Proveedor_idx` (`Proveedor_Id_Proveedor` ASC) VISIBLE,
  CONSTRAINT `fk_Marca_Gafas_Proveedor`
    FOREIGN KEY (`Proveedor_Id_Proveedor`)
    REFERENCES `Optica_EER`.`Proveedor` (`Id_Proveedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Optica_EER`.`Gafas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Optica_EER`.`Gafas` (
  `Id_Gafas` INT NOT NULL,
  `Marca_Gafas` VARCHAR(45) NOT NULL,
  `Graduacion_Izq_Gafas` FLOAT NOT NULL,
  `Graduacio_Dret_Ulleres` FLOAT NOT NULL,
  `Tipo_Montura` ENUM('Flotant', 'Pasta', 'Metálica') NOT NULL,
  `Color_Montura` VARCHAR(45) NOT NULL,
  `Color_Cristal_Izq` VARCHAR(45) NOT NULL,
  `Color_Cristal_Der` VARCHAR(45) NOT NULL,
  `Precio_Gafa` FLOAT NOT NULL,
  `Marca_Gafas_Id_Marca` INT NOT NULL,
  PRIMARY KEY (`Id_Gafas`),
  INDEX `fk_Gafas_Marca_Gafas1_idx` (`Marca_Gafas_Id_Marca` ASC) VISIBLE,
  CONSTRAINT `fk_Gafas_Marca_Gafas1`
    FOREIGN KEY (`Marca_Gafas_Id_Marca`)
    REFERENCES `Optica_EER`.`Marca_Gafas` (`Id_Marca`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Optica_EER`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Optica_EER`.`Cliente` (
  `Id_Cliente` INT NOT NULL,
  `Nombre_Cliente` VARCHAR(45) NOT NULL,
  `Dirección_Cliente` VARCHAR(75) NOT NULL,
  `Telefono_Cliente` INT NOT NULL,
  `Correo_Electronico_Cliente` VARCHAR(45) NOT NULL,
  `Data_Registro_Cliente` DATE NOT NULL,
  `Cliente_que_Recomendo_Id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Id_Cliente`),
  CONSTRAINT `fk_Cliente_Recomendado`
    FOREIGN KEY ()
    REFERENCES `Optica_EER`.`Cliente` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Optica_EER`.`Dirección`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Optica_EER`.`Dirección` (
  `Id_Dirección` INT NOT NULL,
  `Calle` VARCHAR(45) NOT NULL,
  `Numero_Portal` INT NOT NULL,
  `Numero_Piso` INT NOT NULL,
  `Numero_Puerta` INT NOT NULL,
  `Ciudad` VARCHAR(45) NOT NULL,
  `Codigo_Postal` INT NOT NULL,
  `Pais` VARCHAR(45) NOT NULL,
  `Tipo` ENUM('Proveedor', 'Cliente') NOT NULL,
  `Proveedor_Id_Proveedor` INT NOT NULL,
  INDEX `fk_Dirección_Proveedor1_idx` (`Proveedor_Id_Proveedor` ASC) VISIBLE,
  CONSTRAINT `fk_Dirección_Proveedor1`
    FOREIGN KEY (`Proveedor_Id_Proveedor`)
    REFERENCES `Optica_EER`.`Proveedor` (`Id_Proveedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Optica_EER`.`Empleado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Optica_EER`.`Empleado` (
  `Id_Empleado` INT NOT NULL,
  `Nombre_Empleado` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Id_Empleado`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Optica_EER`.`Ventas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Optica_EER`.`Ventas` (
  `Id_Venta` INT NOT NULL,
  `Fecha_Venta` DATE NOT NULL,
  `Precio_Venta` INT NOT NULL,
  `Empleado_Id_Empleado` INT NOT NULL,
  `Gafas_Id_Gafas` INT NOT NULL,
  `Cliente_Id_Cliente` INT NOT NULL,
  PRIMARY KEY (`Id_Venta`),
  INDEX `fk_Ventas_Empleado1_idx` (`Empleado_Id_Empleado` ASC) VISIBLE,
  INDEX `fk_Ventas_Gafas1_idx` (`Gafas_Id_Gafas` ASC) VISIBLE,
  INDEX `fk_Ventas_Cliente1_idx` (`Cliente_Id_Cliente` ASC) VISIBLE,
  CONSTRAINT `fk_Ventas_Empleado1`
    FOREIGN KEY (`Empleado_Id_Empleado`)
    REFERENCES `Optica_EER`.`Empleado` (`Id_Empleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ventas_Gafas1`
    FOREIGN KEY (`Gafas_Id_Gafas`)
    REFERENCES `Optica_EER`.`Gafas` (`Id_Gafas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ventas_Cliente1`
    FOREIGN KEY (`Cliente_Id_Cliente`)
    REFERENCES `Optica_EER`.`Cliente` (`Id_Cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
