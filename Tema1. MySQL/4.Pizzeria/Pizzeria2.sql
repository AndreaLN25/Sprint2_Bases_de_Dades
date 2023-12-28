-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Pizzeria
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Pizzeria
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Pizzeria` DEFAULT CHARACTER SET utf8 ;
USE `Pizzeria` ;

-- -----------------------------------------------------
-- Table `Pizzeria`.`Tiendas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`Tiendas` (
  `idTiendas` INT NOT NULL AUTO_INCREMENT,
  `Direccion_Tienda` VARCHAR(45) NOT NULL,
  `Codigo_Postal_Tienda` INT NULL,
  `Localidad_Tienda` INT NULL,
  `Provincia_Tienda` INT NULL,
  PRIMARY KEY (`idTiendas`),
  UNIQUE INDEX `idTiendas_UNIQUE` (`idTiendas` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`Empleados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`Empleados` (
  `idEmpleados` INT NOT NULL AUTO_INCREMENT,
  `Nombre_Empleado` VARCHAR(45) NOT NULL,
  `Apellido_Empleado` VARCHAR(45) NOT NULL,
  `NIF_Empleado` VARCHAR(15) NOT NULL,
  `Telefono_Empleado` INT NOT NULL,
  `Tipo_Empleado` VARCHAR(45) NULL,
  `Tiendas_idTiendas` INT NOT NULL,
  PRIMARY KEY (`idEmpleados`),
  UNIQUE INDEX `idEmpleados_UNIQUE` (`idEmpleados` ASC) VISIBLE,
  UNIQUE INDEX `NIF_Empleado_UNIQUE` (`NIF_Empleado` ASC) VISIBLE,
  UNIQUE INDEX `Telefono_Empleado_UNIQUE` (`Telefono_Empleado` ASC) VISIBLE,
  INDEX `fk_Empleados_Tiendas1_idx` (`Tiendas_idTiendas` ASC) VISIBLE,
  CONSTRAINT `fk_Empleados_Tiendas1`
    FOREIGN KEY (`Tiendas_idTiendas`)
    REFERENCES `Pizzeria`.`Tiendas` (`idTiendas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`Repartidor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`Repartidor` (
  `idRepartidor` INT NOT NULL AUTO_INCREMENT,
  `Empleados_idEmpleados` INT NOT NULL,
  `PEdiDomicilio_idPEdiDomicilio` INT NOT NULL,
  PRIMARY KEY (`idRepartidor`, `PEdiDomicilio_idPEdiDomicilio`),
  UNIQUE INDEX `idRepartidor_UNIQUE` (`idRepartidor` ASC) VISIBLE,
  INDEX `fk_Repartidor_Empleados1_idx` (`Empleados_idEmpleados` ASC) VISIBLE,
  CONSTRAINT `fk_Repartidor_Empleados1`
    FOREIGN KEY (`Empleados_idEmpleados`)
    REFERENCES `Pizzeria`.`Empleados` (`idEmpleados`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`Detalles_Pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`Detalles_Pedido` (
  `idDetalles_Pedido` INT NOT NULL AUTO_INCREMENT,
  `id_Producto` INT NOT NULL,
  `Cantidad` INT NOT NULL,
  `Precio` FLOAT NOT NULL,
  `Pedidos_idPedidos` INT NOT NULL,
  PRIMARY KEY (`idDetalles_Pedido`),
  INDEX `fk_Detalles_Pedido_Pedidos1_idx` (`Pedidos_idPedidos` ASC) VISIBLE,
  CONSTRAINT `fk_Detalles_Pedido_Pedidos1`
    FOREIGN KEY (`Pedidos_idPedidos`)
    REFERENCES `Pizzeria`.`Pedidos` (`idPedidos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`PEdiDomicilio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`PEdiDomicilio` (
  `idPEdiDomicilio` INT NOT NULL,
  `Fecha_Hora_Reparto` DATETIME NULL,
  `Repartidor_idRepartidor` INT NOT NULL,
  `Repartidor_PEdiDomicilio_idPEdiDomicilio` INT NOT NULL,
  `Tiendas_idTiendas` INT NOT NULL,
  `Detalles_Pedido_idDetalles_Pedido` INT NOT NULL,
  PRIMARY KEY (`idPEdiDomicilio`),
  INDEX `fk_PEdiDomicilio_Repartidor1_idx` (`Repartidor_idRepartidor` ASC, `Repartidor_PEdiDomicilio_idPEdiDomicilio` ASC) VISIBLE,
  INDEX `fk_PEdiDomicilio_Tiendas1_idx` (`Tiendas_idTiendas` ASC) VISIBLE,
  INDEX `fk_PEdiDomicilio_Detalles_Pedido1_idx` (`Detalles_Pedido_idDetalles_Pedido` ASC) VISIBLE,
  CONSTRAINT `fk_PEdiDomicilio_Repartidor1`
    FOREIGN KEY (`Repartidor_idRepartidor` , `Repartidor_PEdiDomicilio_idPEdiDomicilio`)
    REFERENCES `Pizzeria`.`Repartidor` (`idRepartidor` , `PEdiDomicilio_idPEdiDomicilio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PEdiDomicilio_Tiendas1`
    FOREIGN KEY (`Tiendas_idTiendas`)
    REFERENCES `Pizzeria`.`Tiendas` (`idTiendas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PEdiDomicilio_Detalles_Pedido1`
    FOREIGN KEY (`Detalles_Pedido_idDetalles_Pedido`)
    REFERENCES `Pizzeria`.`Detalles_Pedido` (`idDetalles_Pedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`Pedidos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`Pedidos` (
  `idPedidos` INT NOT NULL AUTO_INCREMENT,
  `Fecha_Pedido` DATE NOT NULL,
  `Tipo_pedido` VARCHAR(45) NOT NULL,
  `Total_Productos_Pedido` INT NOT NULL,
  `Precio_pedido` INT NOT NULL DEFAULT 0,
  `Tiendas_idTiendas` INT NOT NULL,
  `PEdiDomicilio_idPEdiDomicilio` INT NOT NULL,
  PRIMARY KEY (`idPedidos`),
  INDEX `fk_Pedidos_Tiendas1_idx` (`Tiendas_idTiendas` ASC) VISIBLE,
  INDEX `fk_Pedidos_PEdiDomicilio1_idx` (`PEdiDomicilio_idPEdiDomicilio` ASC) VISIBLE,
  CONSTRAINT `fk_Pedidos_Tiendas1`
    FOREIGN KEY (`Tiendas_idTiendas`)
    REFERENCES `Pizzeria`.`Tiendas` (`idTiendas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pedidos_PEdiDomicilio1`
    FOREIGN KEY (`PEdiDomicilio_idPEdiDomicilio`)
    REFERENCES `Pizzeria`.`PEdiDomicilio` (`idPEdiDomicilio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`Clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`Clientes` (
  `idClientes` INT NOT NULL AUTO_INCREMENT,
  `Nombre_Cliente` VARCHAR(45) NOT NULL,
  `Apellidos_Cliente` VARCHAR(45) NOT NULL,
  `Dirección_Cliente` VARCHAR(45) NULL,
  `Codigo_Postal_Cliente` INT NULL,
  `Localidad_Cliente` VARCHAR(25) NULL,
  `Provincia_Cliente` VARCHAR(25) NOT NULL,
  `Telefono_Cliente` INT NOT NULL,
  `Pedidos_idPedidos` INT NOT NULL,
  PRIMARY KEY (`idClientes`),
  UNIQUE INDEX `Telefono_Cliente_UNIQUE` (`Telefono_Cliente` ASC) VISIBLE,
  INDEX `fk_Clientes_Pedidos2_idx` (`Pedidos_idPedidos` ASC) VISIBLE,
  CONSTRAINT `fk_Clientes_Pedidos2`
    FOREIGN KEY (`Pedidos_idPedidos`)
    REFERENCES `Pizzeria`.`Pedidos` (`idPedidos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`Categorias_Pizzas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`Categorias_Pizzas` (
  `idCategorias_Pizzas` INT NOT NULL,
  `Nombre_Categoria_Pizza` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idCategorias_Pizzas`),
  UNIQUE INDEX `idCategorias_Pizzas_UNIQUE` (`idCategorias_Pizzas` ASC) VISIBLE,
  UNIQUE INDEX `Nombre_Categoria_Pizza_UNIQUE` (`Nombre_Categoria_Pizza` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`Tipo_Producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`Tipo_Producto` (
  `idTipo_Producto` INT NOT NULL AUTO_INCREMENT,
  `Tipo_Producto` VARCHAR(45) NOT NULL,
  `Detalles_Pedido_idDetalles_Pedido` INT NOT NULL,
  `Categorias_Pizzas_idCategorias_Pizzas` INT NOT NULL,
  `Pedidos_idPedidos` INT NOT NULL,
  PRIMARY KEY (`idTipo_Producto`),
  INDEX `fk_Tipo_Producto_Detalles_Pedido1_idx` (`Detalles_Pedido_idDetalles_Pedido` ASC) VISIBLE,
  INDEX `fk_Tipo_Producto_Categorias_Pizzas1_idx` (`Categorias_Pizzas_idCategorias_Pizzas` ASC) VISIBLE,
  INDEX `fk_Tipo_Producto_Pedidos1_idx` (`Pedidos_idPedidos` ASC) VISIBLE,
  CONSTRAINT `fk_Tipo_Producto_Detalles_Pedido1`
    FOREIGN KEY (`Detalles_Pedido_idDetalles_Pedido`)
    REFERENCES `Pizzeria`.`Detalles_Pedido` (`idDetalles_Pedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Tipo_Producto_Categorias_Pizzas1`
    FOREIGN KEY (`Categorias_Pizzas_idCategorias_Pizzas`)
    REFERENCES `Pizzeria`.`Categorias_Pizzas` (`idCategorias_Pizzas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Tipo_Producto_Pedidos1`
    FOREIGN KEY (`Pedidos_idPedidos`)
    REFERENCES `Pizzeria`.`Pedidos` (`idPedidos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`Detalles_Producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`Detalles_Producto` (
  `id_Detalle_Producto` INT NOT NULL AUTO_INCREMENT,
  `Nombre_Produto` VARCHAR(45) NULL,
  `Descripcion_Producto` VARCHAR(45) NULL,
  `Imagen_Producto` VARCHAR(45) NULL,
  `Precio_Producto` FLOAT NULL,
  `Pedidos_idPedidos` INT NOT NULL,
  `Tiendas_idTiendas` INT NOT NULL,
  `Tipo_Producto` VARCHAR(45) NOT NULL,
  `Tipo_Producto_idTipo_Producto` INT NOT NULL,
  PRIMARY KEY (`id_Detalle_Producto`),
  INDEX `fk_Productos_Pedido_Pedidos1_idx` (`Pedidos_idPedidos` ASC) VISIBLE,
  INDEX `fk_Productos_Pedido_Tiendas1_idx` (`Tiendas_idTiendas` ASC) VISIBLE,
  INDEX `fk_Detalles_Producto_Tipo_Producto1_idx` (`Tipo_Producto_idTipo_Producto` ASC) VISIBLE,
  CONSTRAINT `fk_Productos_Pedido_Pedidos1`
    FOREIGN KEY (`Pedidos_idPedidos`)
    REFERENCES `Pizzeria`.`Pedidos` (`idPedidos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Productos_Pedido_Tiendas1`
    FOREIGN KEY (`Tiendas_idTiendas`)
    REFERENCES `Pizzeria`.`Tiendas` (`idTiendas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Detalles_Producto_Tipo_Producto1`
    FOREIGN KEY (`Tipo_Producto_idTipo_Producto`)
    REFERENCES `Pizzeria`.`Tipo_Producto` (`idTipo_Producto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`Cocinero`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`Cocinero` (
  `idCocinero` INT NOT NULL,
  `Empleados_idEmpleados` INT NOT NULL,
  PRIMARY KEY (`idCocinero`),
  INDEX `fk_Cocinero_Empleados1_idx` (`Empleados_idEmpleados` ASC) VISIBLE,
  CONSTRAINT `fk_Cocinero_Empleados1`
    FOREIGN KEY (`Empleados_idEmpleados`)
    REFERENCES `Pizzeria`.`Empleados` (`idEmpleados`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
