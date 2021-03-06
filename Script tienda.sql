
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Tienda
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `Tienda` ;

-- -----------------------------------------------------
-- Schema Tienda
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Tienda` DEFAULT CHARACTER SET utf8 ;
USE `Tienda` ;

-- -----------------------------------------------------
-- Table `Tienda`.`Talle`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Tienda`.`Talle` (
  `idTalle` INT NOT NULL,
  `Talle` VARCHAR(45) NOT NULL,
  `Tipo_Manga` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idTalle`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Tienda`.`Estampado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Tienda`.`Estampado` (
  `idEstampado` INT NOT NULL,
  `Apellido` VARCHAR(45) NULL,
  `Nombre` VARCHAR(45) NULL,
  `Numero` TINYINT NULL,
  PRIMARY KEY (`idEstampado`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Tienda`.`Club`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Tienda`.`Club` (
  `idClub` INT NOT NULL,
  `Club` VARCHAR(45) NOT NULL,
  `Año` TINYINT NOT NULL,
  PRIMARY KEY (`idClub`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Tienda`.`Proovedores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Tienda`.`Proovedores` (
  `idProovedor` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NOT NULL,
  `Apellido` VARCHAR(45) NOT NULL,
  `Email` VARCHAR(45) NULL,
  `Telefono` TINYINT NULL,
  PRIMARY KEY (`idProovedor`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Tienda`.`Descuento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Tienda`.`Descuento` (
  `idDescuento` INT NOT NULL,
  `tiene` TINYINT NOT NULL,
  PRIMARY KEY (`idDescuento`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Tienda`.`Recargo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Tienda`.`Recargo` (
  `idRecargo` INT NOT NULL,
  `tiene` TINYINT NOT NULL,
  PRIMARY KEY (`idRecargo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Tienda`.`Medios de pago`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Tienda`.`Medios de pago` (
  `idMedios_de_pago` INT NOT NULL,
  `efectivo` TINYINT NOT NULL,
  `tarjeta` TINYINT NOT NULL,
  `cheque` TINYINT NOT NULL,
  `transferencia` VARCHAR(45) NOT NULL,
  `Descuento_idDescuento` INT NOT NULL,
  `Recargo_idRecargo` INT NOT NULL,
  PRIMARY KEY (`idMedios_de_pago`, `Descuento_idDescuento`, `Recargo_idRecargo`),
  CONSTRAINT `fk_Medios de pago_Descuento1`
    FOREIGN KEY (`Descuento_idDescuento`)
    REFERENCES `Tienda`.`Descuento` (`idDescuento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Medios de pago_Recargo1`
    FOREIGN KEY (`Recargo_idRecargo`)
    REFERENCES `Tienda`.`Recargo` (`idRecargo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Medios de pago_Descuento1_idx` ON `Tienda`.`Medios de pago` (`Descuento_idDescuento` ASC) ;

CREATE INDEX `fk_Medios de pago_Recargo1_idx` ON `Tienda`.`Medios de pago` (`Recargo_idRecargo` ASC) ;


-- -----------------------------------------------------
-- Table `Tienda`.`Producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Tienda`.`Producto` (
  `idProducto` INT NOT NULL,
  `Talle_idTalle` INT NOT NULL,
  `Proovedores_idProovedor` INT NOT NULL,
  `Estampado_idEstampado` INT NOT NULL,
  `Club_idClub` INT NOT NULL,
  `Medios de pago_idMedios_de_pago` INT NOT NULL,
  PRIMARY KEY (`idProducto`),
  CONSTRAINT `fk_Producto_Talle1`
    FOREIGN KEY (`Talle_idTalle`)
    REFERENCES `Tienda`.`Talle` (`idTalle`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Producto_Estampado1`
    FOREIGN KEY (`Estampado_idEstampado`)
    REFERENCES `Tienda`.`Estampado` (`idEstampado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Producto_Club1`
    FOREIGN KEY (`Club_idClub`)
    REFERENCES `Tienda`.`Club` (`idClub`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Producto_Proovedores1`
    FOREIGN KEY (`Proovedores_idProovedor`)
    REFERENCES `Tienda`.`Proovedores` (`idProovedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Producto_Medios de pago1`
    FOREIGN KEY (`Medios de pago_idMedios_de_pago`)
    REFERENCES `Tienda`.`Medios de pago` (`idMedios_de_pago`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Producto_Talle1_idx` ON `Tienda`.`Producto` (`Talle_idTalle` ASC) ;

CREATE INDEX `fk_Producto_Estampado1_idx` ON `Tienda`.`Producto` (`Estampado_idEstampado` ASC) ;

CREATE INDEX `fk_Producto_Club1_idx` ON `Tienda`.`Producto` (`Club_idClub` ASC) ;

CREATE INDEX `fk_Producto_Proovedores1_idx` ON `Tienda`.`Producto` (`Proovedores_idProovedor` ASC) ;

CREATE INDEX `fk_Producto_Medios de pago1_idx` ON `Tienda`.`Producto` (`Medios de pago_idMedios_de_pago` ASC) ;


-- -----------------------------------------------------
-- Table `Tienda`.`Clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Tienda`.`Clientes` (
  `idClientes` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NOT NULL,
  `Apellido` VARCHAR(45) NOT NULL,
  `Email` VARCHAR(45) NOT NULL,
  `Codigo_Postal` TINYINT NOT NULL,
  `Producto_idProducto` INT NOT NULL,
  PRIMARY KEY (`idClientes`),
  CONSTRAINT `fk_Clientes_Producto1`
    FOREIGN KEY (`Producto_idProducto`)
    REFERENCES `Tienda`.`Producto` (`idProducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Clientes_Producto1_idx` ON `Tienda`.`Clientes` (`Producto_idProducto` ASC) ;


-- -----------------------------------------------------
-- Table `Tienda`.`Stats`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Tienda`.`Stats` (
  `games` INT NOT NULL AUTO_INCREMENT,
  `win` INT NOT NULL,
  `loss` INT NOT NULL,
  `kills` INT NOT NULL,
  `assists` INT NOT NULL,
  `k/d` DECIMAL NOT NULL,
  `deaths` INT NOT NULL,
  PRIMARY KEY (`games`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Tienda`.`Players`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Tienda`.`Players` (
  `nick_name` INT NOT NULL AUTO_INCREMENT,
  `age` VARCHAR(45) NOT NULL,
  `plataform` VARCHAR(45) NOT NULL,
  `country` VARCHAR(45) NOT NULL,
  `zip/code_postal` VARCHAR(45) NOT NULL,
  `Stats_games` INT NOT NULL,
  PRIMARY KEY (`nick_name`, `Stats_games`),
  CONSTRAINT `fk_Players_Stats1`
    FOREIGN KEY (`Stats_games`)
    REFERENCES `Tienda`.`Stats` (`games`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Players_Stats1_idx` ON `Tienda`.`Players` (`Stats_games` ASC) ;


-- -----------------------------------------------------
-- Table `Tienda`.`Videogame`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Tienda`.`Videogame` (
  `idVideogame` INT NOT NULL AUTO_INCREMENT,
  `genre` VARCHAR(45) NOT NULL,
  `mode` VARCHAR(45) NOT NULL,
  `publisher` VARCHAR(45) NOT NULL,
  `date_release` DATE NOT NULL,
  `Players_nick_name` INT NOT NULL,
  PRIMARY KEY (`idVideogame`),
  CONSTRAINT `fk_Videogame_Players1`
    FOREIGN KEY (`Players_nick_name`)
    REFERENCES `Tienda`.`Players` (`nick_name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Videogame_Players1_idx` ON `Tienda`.`Videogame` (`Players_nick_name` ASC) ;


-- -----------------------------------------------------
-- Table `Tienda`.`Company`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Tienda`.`Company` (
  `idCompany` INT NOT NULL,
  `date_founded` DATE NOT NULL,
  `country` VARCHAR(45) NOT NULL,
  `website` VARCHAR(45) NOT NULL,
  `Videogame_idVideogame` INT NOT NULL,
  PRIMARY KEY (`idCompany`),
  CONSTRAINT `fk_Company_Videogame1`
    FOREIGN KEY (`Videogame_idVideogame`)
    REFERENCES `Tienda`.`Videogame` (`idVideogame`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Company_Videogame1_idx` ON `Tienda`.`Company` (`Videogame_idVideogame` ASC) ;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
