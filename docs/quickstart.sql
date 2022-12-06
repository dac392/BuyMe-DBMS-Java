DROP SCHEMA IF EXISTS `BuyMe`;
CREATE SCHEMA `BuyMe`;
USE `BuyMe`;

CREATE TABLE `Enduser` (
	`username` varchar(255) primary key,
	`name` varchar(255),
	`email` varchar(255),
	`password` varchar(255),
	`isstaff` boolean,
	`isadministrative` boolean
);

INSERT INTO Enduser(name, username, email, password, isstaff, isadministrative) VALUES
	("Admin", "Admin", "admin@buyme.com", "", true, true);

CREATE TABLE `BuyMe`.`Sellsproduct` (
  `aid` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(15) NULL,
  `minimumprice` DOUBLE NULL,
  `amount` DOUBLE NULL,
  `bidincrement` DOUBLE NULL,
  `deadline` DATE NULL,
  `category` VARCHAR(255) NULL,
  `subcategory` VARCHAR(255) NULL,
  `size` VARCHAR(255) NULL,
  `color` VARCHAR(255) NULL,
  `link` VARCHAR(255) NULL,
  PRIMARY KEY (`aid`),
  INDEX `username_idx` (`username` ASC) VISIBLE,
  CONSTRAINT `sp_username`
    FOREIGN KEY (`username`)
    REFERENCES `BuyMe`.`Enduser` (`username`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE `BuyMe`.`Notifications` (
	`nid` INT NOT NULL AUTO_INCREMENT,
	`username` VARCHAR(255),
	`description` VARCHAR(255) NULL,
	`posttime` DATETIME,
	PRIMARY KEY (`nid`, `username`),
	CONSTRAINT `n_username`
		FOREIGN KEY (`username`)
		REFERENCES `BuyMe`.`Enduser`(`username`)
		ON DELETE CASCADE
		ON UPDATE CASCADE
);

CREATE TABLE `BuyMe`.`Assets` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `link` VARCHAR(255) NULL,
  PRIMARY KEY (`id`)
);

INSERT INTO `BuyMe`.`Assets` VALUES 
(NULL, "Assets/crewneck/black/"),
(NULL, "Assets/crewneck/brown/"),
(NULL, "Assets/crewneck/grey/"),
(NULL, "Assets/crewneck/green/"),

(NULL, "Assets/hoodie/black/"),
(NULL, "Assets/hoodie/brown/"),
(NULL, "Assets/hoodie/grey/"),
(NULL, "Assets/hoodie/green/"),

(NULL, "Assets/zipup/black/"),
(NULL, "Assets/zipup/brown/"),
(NULL, "Assets/zipup/grey/"),
(NULL, "Assets/zipup/green/"),

(NULL, "Assets/fleece/black/"),
(NULL, "Assets/fleece/brown/"),
(NULL, "Assets/fleece/grey/"),
(NULL, "Assets/fleece/green/"),

(NULL, "Assets/jeans/black/"),
(NULL, "Assets/jeans/blue/"),
(NULL, "Assets/jeans/grey/"),

(NULL, "Assets/sweatpants/black/"),
(NULL, "Assets/sweatpants/blue/"),
(NULL, "Assets/sweatpants/brown/"),
(NULL, "Assets/sweatpants/grey/"),

;