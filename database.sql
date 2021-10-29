-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema CinehogarDB
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema CinehogarDB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `CinehogarDB` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `CinehogarDB` ;

-- -----------------------------------------------------
-- Table `CinehogarDB`.`user_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CinehogarDB`.`user_type` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `CinehogarDB`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CinehogarDB`.`user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(45) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `is_email_verified` TINYINT(1) NOT NULL,
  `user_type_id` INT NOT NULL,
  `created_at` DATETIME NOT NULL,
  `last_connected` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  INDEX `fk_user_user_type1_idx` (`user_type_id` ASC) VISIBLE,
  CONSTRAINT `fk_user_user_type1`
    FOREIGN KEY (`user_type_id`)
    REFERENCES `CinehogarDB`.`user_type` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 19
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `CinehogarDB`.`connected_devices`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CinehogarDB`.`connected_devices` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `device_count` TINYINT(1) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_connected_devices_user1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_connected_devices_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `CinehogarDB`.`user` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `CinehogarDB`.`invite_list`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CinehogarDB`.`invite_list` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `date` DATETIME NOT NULL,
  `user_id` INT NOT NULL,
  `guest_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_invite_list_user1_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_invite_list_user2_idx` (`guest_id` ASC) VISIBLE,
  CONSTRAINT `fk_invite_list_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `CinehogarDB`.`user` (`id`),
  CONSTRAINT `fk_invite_list_user2`
    FOREIGN KEY (`guest_id`)
    REFERENCES `CinehogarDB`.`user` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `CinehogarDB`.`media_quality`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CinehogarDB`.`media_quality` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(255) NOT NULL DEFAULT '',
  `video_quality` VARCHAR(10) NOT NULL,
  `resolution` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `CinehogarDB`.`payment_method`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CinehogarDB`.`payment_method` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `method` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `CinehogarDB`.`payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CinehogarDB`.`payment` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `date` DATETIME NOT NULL,
  `amount` INT NOT NULL,
  `payment_method_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_payments_payment_method1_idx` (`payment_method_id` ASC) VISIBLE,
  CONSTRAINT `fk_payments_payment_method1`
    FOREIGN KEY (`payment_method_id`)
    REFERENCES `CinehogarDB`.`payment_method` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `CinehogarDB`.`plan`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CinehogarDB`.`plan` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `price` FLOAT NOT NULL,
  `description` VARCHAR(255) NOT NULL,
  `maximum_profiles` TINYINT(1) NOT NULL,
  `can_invite` TINYINT(1) NOT NULL,
  `media_quality_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_plan_media_quality1_idx` (`media_quality_id` ASC) VISIBLE,
  CONSTRAINT `fk_plan_media_quality1`
    FOREIGN KEY (`media_quality_id`)
    REFERENCES `CinehogarDB`.`media_quality` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 15
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `CinehogarDB`.`profile`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CinehogarDB`.`profile` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `avatar` VARCHAR(45) NOT NULL,
  `birthdate` DATETIME NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_profile_user1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_profile_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `CinehogarDB`.`user` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `CinehogarDB`.`session`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CinehogarDB`.`session` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `imdb_id` INT NOT NULL,
  `progress_time` VARCHAR(45) NOT NULL,
  `finished` TINYINT(1) NOT NULL,
  `date` DATETIME NOT NULL,
  `profile_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_session_profile1_idx` (`profile_id` ASC) VISIBLE,
  CONSTRAINT `fk_session_profile1`
    FOREIGN KEY (`profile_id`)
    REFERENCES `CinehogarDB`.`profile` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `CinehogarDB`.`subscription`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CinehogarDB`.`subscription` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `plan_id` INT NOT NULL,
  `payments_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_subscription_user_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_subscription_plan1_idx` (`plan_id` ASC) VISIBLE,
  INDEX `fk_subscription_payments1_idx` (`payments_id` ASC) VISIBLE,
  CONSTRAINT `fk_subscription_payments1`
    FOREIGN KEY (`payments_id`)
    REFERENCES `CinehogarDB`.`payment` (`id`),
  CONSTRAINT `fk_subscription_plan1`
    FOREIGN KEY (`plan_id`)
    REFERENCES `CinehogarDB`.`plan` (`id`),
  CONSTRAINT `fk_subscription_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `CinehogarDB`.`user` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
