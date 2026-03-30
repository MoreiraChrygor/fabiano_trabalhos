-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema interclasse
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema interclasse
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `interclasse` DEFAULT CHARACTER SET utf8 ;
USE `interclasse` ;

-- -----------------------------------------------------
-- Table `interclasse`.`tbl_modalidade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `interclasse`.`tbl_modalidade` (
  `id_modalidade` INT NOT NULL,
  `modalidade` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`id_modalidade`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `interclasse`.`tbl_times`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `interclasse`.`tbl_times` (
  `idl_times` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `tbl_modalidade_id_modalidade` INT NOT NULL,
  PRIMARY KEY (`idl_times`),
  INDEX `fk_tbl_times_tbl_modalidade1_idx` (`tbl_modalidade_id_modalidade` ASC) VISIBLE,
  CONSTRAINT `fk_tbl_times_tbl_modalidade1`
    FOREIGN KEY (`tbl_modalidade_id_modalidade`)
    REFERENCES `interclasse`.`tbl_modalidade` (`id_modalidade`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `interclasse`.`tbl_jogadores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `interclasse`.`tbl_jogadores` (
  `id_jogadores` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_jogadores`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `interclasse`.`boletim`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `interclasse`.`boletim` (
  `id_boletim` INT NOT NULL AUTO_INCREMENT,
  `frequencia` TINYINT NOT NULL,
  `mencao` TINYINT NOT NULL,
  `ocorrencia` INT NOT NULL,
  `tbl_jogadores_id_jogadores` INT NOT NULL,
  PRIMARY KEY (`id_boletim`),
  INDEX `fk_boletim_tbl_jogadores1_idx` (`tbl_jogadores_id_jogadores` ASC) VISIBLE,
  CONSTRAINT `fk_boletim_tbl_jogadores1`
    FOREIGN KEY (`tbl_jogadores_id_jogadores`)
    REFERENCES `interclasse`.`tbl_jogadores` (`id_jogadores`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `interclasse`.`tbl_jogadores_has_tbl_times`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `interclasse`.`tbl_jogadores_has_tbl_times` (
  `tbl_jogadores_id_jogadores` INT NOT NULL,
  `tbl_times_idl_times` INT NOT NULL,
  PRIMARY KEY (`tbl_jogadores_id_jogadores`, `tbl_times_idl_times`),
  INDEX `fk_tbl_jogadores_has_tbl_times_tbl_times1_idx` (`tbl_times_idl_times` ASC) VISIBLE,
  INDEX `fk_tbl_jogadores_has_tbl_times_tbl_jogadores1_idx` (`tbl_jogadores_id_jogadores` ASC) VISIBLE,
  CONSTRAINT `fk_tbl_jogadores_has_tbl_times_tbl_jogadores1`
    FOREIGN KEY (`tbl_jogadores_id_jogadores`)
    REFERENCES `interclasse`.`tbl_jogadores` (`id_jogadores`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tbl_jogadores_has_tbl_times_tbl_times1`
    FOREIGN KEY (`tbl_times_idl_times`)
    REFERENCES `interclasse`.`tbl_times` (`idl_times`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- inserts

INSERT INTO tbl_modalidade (id_modalidade, modalidade) VALUES
(1, 'Futebol'),
(2, 'Voleibol'),
(3, 'Basquete'),
(4, 'Handebol');

INSERT INTO tbl_times (nome, tbl_modalidade_id_modalidade) VALUES
('1A Futebol', 1),
('2B Futebol', 1),
('1A Volei', 2),
('2C Basquete', 3),
('3A Handebol', 4);

INSERT INTO tbl_jogadores (nome) VALUES
('João Silva'),
('Pedro Santos'),
('Lucas Oliveira'),
('Marcos Souza'),
('Ana Costa'),
('Beatriz Lima'),
('Carlos Pereira');

INSERT INTO tbl_jogadores_has_tbl_times (tbl_jogadores_id_jogadores, tbl_times_idl_times) VALUES
(1, 1),
(2, 1),
(3, 2),
(4, 3),
(5, 4),
(6, 5),
(7, 2),
(1, 2), -- jogador em mais de um time
(3, 1);

INSERT INTO boletim (frequencia, mencao, ocorrencia, tbl_jogadores_id_jogadores) VALUES
(95, 9, 1, 1),
(88, 8, 2, 2),
(75, 7, 3, 3),
(60, 6, 4, 4),
(98, 10, 5, 5),
(85, 8, 6, 6),
(70, 7, 7, 7);

-- select comfirmação com inner join e left

SELECT 
    j.nome AS jogador,
    t.nome AS time,
    m.modalidade,
    b.frequencia,
    b.mencao
FROM tbl_jogadores j
JOIN tbl_jogadores_has_tbl_times jt 
    ON j.id_jogadores = jt.tbl_jogadores_id_jogadores
JOIN tbl_times t 
    ON t.idl_times = jt.tbl_times_idl_times
JOIN tbl_modalidade m 
    ON m.id_modalidade = t.tbl_modalidade_id_modalidade
LEFT JOIN boletim b 
    ON b.tbl_jogadores_id_jogadores = j.id_jogadores;
  

-- selects tables

SELECT * FROM interclasse.boletim;

SELECT * FROM interclasse.tbl_jogadores;

SELECT * FROM interclasse.tbl_jogadores_has_tbl_times;

SELECT * FROM interclasse.tbl_modalidade;

SELECT * FROM interclasse.tbl_times;
