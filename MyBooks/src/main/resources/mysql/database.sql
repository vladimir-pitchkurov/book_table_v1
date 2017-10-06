USE test;




CREATE TABLE `test`.`book` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(100) Not NULL,
  `description` VARCHAR(255) NULL,
  `author` VARCHAR(100) NULL,
  `isbn` VARCHAR(20) NULL,
  `printYear` INT NULL,
  `readAlready` TINYINT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `title_UNIQUE` (`title` ASC))
  ENGINE = InnoDB
  DEFAULT CHARACTER SET = utf8;
