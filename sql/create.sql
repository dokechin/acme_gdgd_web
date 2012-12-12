CREATE SCHEMA IF NOT EXISTS `gdgd`;
USE `gdgd` ;
grant all privileges on gdgd.* to gdgd@localhost identified by 'atamishi';

-- -----------------------------------------------------
-- Table `gdgd`.`User`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `gdgd`.`User` (
  `User` VARCHAR(100) NULL ,
  `Key` CHAR(32) NULL ,
  `create_at` TIMESTAMP,
  INDEX `Index1` (`User` ASC) ,
  INDEX `Index2` (`Key` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `gdgd`.`Hook`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `gdgd`.`Hook` (
  `User` VARCHAR(100) NULL,
  `Event` VARCHAR(100) NULL,
  `issued_at` TIMESTAMP,
  INDEX `Index1` (`User` ASC, `issued_at` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


