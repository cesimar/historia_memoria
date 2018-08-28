-- MySQL Script generated by MySQL Workbench
-- Tue Aug 28 06:13:50 2018
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema historia_memoria
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema historia_memoria
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `historia_memoria` DEFAULT CHARACTER SET utf8 ;
USE `historia_memoria` ;

-- -----------------------------------------------------
-- Table `historia_memoria`.`projeto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `historia_memoria`.`projeto` (
  `id` INT NOT NULL,
  `data_cadastro` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `nome` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `historia_memoria`.`categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `historia_memoria`.`categoria` (
  `id` INT NOT NULL,
  `data_cadastro` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `nome` VARCHAR(45) NOT NULL,
  `slug` VARCHAR(255) NULL COMMENT 'Deve ser a referencia do nome da categoria.\n\nExemplo:\nNome da Categoria => nome-da-categoria',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `nome_UNIQUE` (`nome` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `historia_memoria`.`documento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `historia_memoria`.`documento` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `data_cadastro` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `projeto_id` INT NOT NULL,
  `categoria_id` INT NOT NULL,
  `informacoes` LONGTEXT NULL,
  `url` VARCHAR(255) NOT NULL,
  `size` BIGINT NULL COMMENT 'Valor medido em Kilobytes',
  `tipo` VARCHAR(25) NULL DEFAULT 'pdf',
  `nome` VARCHAR(60) NULL,
  `slug` VARCHAR(255) NULL,
  PRIMARY KEY (`id`, `projeto_id`, `categoria_id`),
  INDEX `fk_documento_projeto1_idx` (`projeto_id` ASC) VISIBLE,
  INDEX `fk_documento_categoria1_idx` (`categoria_id` ASC) VISIBLE,
  CONSTRAINT `fk_documento_projeto1`
    FOREIGN KEY (`projeto_id`)
    REFERENCES `historia_memoria`.`projeto` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_documento_categoria1`
    FOREIGN KEY (`categoria_id`)
    REFERENCES `historia_memoria`.`categoria` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `historia_memoria`.`tag`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `historia_memoria`.`tag` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `data_cadastro` TIMESTAMP NULL,
  `nome` VARCHAR(45) NULL,
  `slug` VARCHAR(255) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `historia_memoria`.`documento_tag`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `historia_memoria`.`documento_tag` (
  `documento_id` INT NOT NULL,
  `tags_id` BIGINT NOT NULL,
  `data_cadastro` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`documento_id`, `tags_id`),
  INDEX `fk_documento_has_tags_tags1_idx` (`tags_id` ASC) VISIBLE,
  INDEX `fk_documento_has_tags_documento1_idx` (`documento_id` ASC) VISIBLE,
  CONSTRAINT `fk_documento_has_tags_documento1`
    FOREIGN KEY (`documento_id`)
    REFERENCES `historia_memoria`.`documento` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_documento_has_tags_tags1`
    FOREIGN KEY (`tags_id`)
    REFERENCES `historia_memoria`.`tag` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
