CREATE SCHEMA `testing`;
USE `testing`;

CREATE TABLE `Enduser` (
	`username` varchar(255) primary key,
	`name` varchar(255),
	`email` varchar(255),
	`password` varchar(255),
	`isstaff` boolean,
	`isadministrative` boolean,
	`isbuyer` boolean
);