-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
-- Host: 127.0.0.1
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
-- Database: `orders`
CREATE DATABASE IF NOT EXISTS `orders` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `orders`;

-- Table structure for table `customer`
DROP TABLE IF EXISTS `customer`;
CREATE TABLE `customer` (
  `Customer_id` int(11) NOT NULL,
  `Cust_Name` varchar(25) NOT NULL,
  `City` varchar(15) NOT NULL,
  `Grade` int(11) NOT NULL,
  `Salesman_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- RELATIONSHIPS FOR TABLE `customer`:
--   `Salesman_id`
--       `salesman` -> `Salesman_id` 

-- Dumping data for table `customer`
INSERT INTO `customer` (`Customer_id`, `Cust_Name`, `City`, `Grade`, `Salesman_id`) VALUES
(500, 'Ayra', 'Kashmir', 2, 1000),
(501, 'Emma', 'Cochin', 4, 1001),
(502, 'Finn', 'Bangalore', 6, 1001),
(503, 'Ross', 'Bangalore', 8, 1001),
(504, 'Dale', 'Nilgiri', 10, 1002);

-- Stand-in structure for view `highorder`
-- (See below for the actual view)
--
DROP VIEW IF EXISTS `highorder`;
CREATE TABLE `highorder` (
`Salesman_id` int(11)
,`Customer_id` int(11)
,`Purchase_Amt` int(11)
,`Ord_Date` date
);

-- Table structure for table `orders`
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
  `Ord_No` int(11) NOT NULL,
  `Purchase_Amt` int(11) NOT NULL,
  `Ord_Date` date NOT NULL,
  `Customer_id` int(11) DEFAULT NULL,
  `Salesman_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- RELATIONSHIPS FOR TABLE `orders`:
--   `Customer_id`
--       `customer` -> `Customer_id`
--   `Salesman_id`
--       `salesman` -> `Salesman_id`

-- Dumping data for table `orders`
INSERT INTO `orders` (`Ord_No`, `Purchase_Amt`, `Ord_Date`, `Customer_id`, `Salesman_id`) VALUES
(2001, 5500, '2021-09-01', 502, 1001),
(2002, 6500, '2021-02-07', 503, 1002),
(2003, 7500, '2021-12-15', 504, 1003);

-- Table structure for table `salesman`
DROP TABLE IF EXISTS `salesman`;
CREATE TABLE `salesman` (
  `Salesman_id` int(11) NOT NULL,
  `Name` varchar(25) NOT NULL,
  `City` varchar(15) NOT NULL,
  `Commission` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- RELATIONSHIPS FOR TABLE `salesman`:

-- Dumping data for table `salesman`
INSERT INTO `salesman` (`Salesman_id`, `Name`, `City`, `Commission`) VALUES
(1000, 'Jack', 'Mysore', 10),
(1001, 'Evan', 'Bangalore', 20),
(1002, 'Noah', 'Sydney', 30),
(1003, 'Ryan', 'Madrid', 40);

-- Structure for view `highorder`
--
DROP TABLE IF EXISTS `highorder`;

DROP VIEW IF EXISTS `highorder`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `highorder`  AS SELECT `x`.`Salesman_id` AS `Salesman_id`, `x`.`Customer_id` AS `Customer_id`, `x`.`Purchase_Amt` AS `Purchase_Amt`, `x`.`Ord_Date` AS `Ord_Date` FROM `orders` AS `x` WHERE `x`.`Purchase_Amt` = (select max(`y`.`Purchase_Amt`) from `orders` `y` where `x`.`Ord_Date` = `y`.`Ord_Date`) ;

-- Indexes for dumped tables
--
-- Indexes for table `customer`
ALTER TABLE `customer`
  ADD PRIMARY KEY (`Customer_id`),
  ADD KEY `Salesman_id` (`Salesman_id`);
-- Indexes for table `orders`
ALTER TABLE `orders`
  ADD PRIMARY KEY (`Ord_No`),
  ADD KEY `Customer_id` (`Customer_id`),
  ADD KEY `Salesman_id` (`Salesman_id`);
-- Indexes for table `salesman`
--
ALTER TABLE `salesman`
  ADD PRIMARY KEY (`Salesman_id`);
-- Constraints for dumped tables
--
-- Constraints for table `customer`
ALTER TABLE `customer`
  ADD CONSTRAINT `customer_ibfk_1` FOREIGN KEY (`Salesman_id`) REFERENCES `salesman` (`Salesman_id`) ON DELETE SET NULL;
-- Constraints for table `orders`
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`Customer_id`) REFERENCES `customer` (`Customer_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`Salesman_id`) REFERENCES `salesman` (`Salesman_id`) ON DELETE CASCADE;
COMMIT;