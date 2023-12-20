-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

-- Database: `library`
CREATE DATABASE IF NOT EXISTS `library` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `library`;

-- Table structure for table `book`
DROP TABLE IF EXISTS `book`;
CREATE TABLE IF NOT EXISTS `book` (
  `Book_ID` int(11) NOT NULL,
  `Title` varchar(20) DEFAULT NULL,
  `Publisher__Name` varchar(20) DEFAULT NULL,
  `Publication_Year` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`Book_ID`),
  KEY `Publisher__Name` (`Publisher__Name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- RELATIONSHIPS FOR TABLE `book`:
--   `Publisher__Name`
--       `publisher` -> `Name`
-- Dumping data for table `book`
INSERT INTO `book` (`Book_ID`, `Title`, `Publisher__Name`, `Publication_Year`) VALUES
(2, 'DBMS for Beginners', 'Mehwish', 'Jun-2017');

-- Table structure for table `book_authors`

DROP TABLE IF EXISTS `book_authors`;
CREATE TABLE IF NOT EXISTS `book_authors` (
  `Book_ID` int(11) NOT NULL,
  `Author_Name` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`Book_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- RELATIONSHIPS FOR TABLE `book_authors`:
--   `Book_ID`
--       `book` -> `Book_ID`
-- Dumping data for table `book_authors`
INSERT INTO `book_authors` (`Book_ID`, `Author_Name`) VALUES
(2, 'Mehwish');

-- Table structure for table `book_copies`

DROP TABLE IF EXISTS `book_copies`;
CREATE TABLE IF NOT EXISTS `book_copies` (
  `Book_ID` int(11) NOT NULL,
  `Programme_ID` int(11) NOT NULL,
  `No_of_Copies` int(11) DEFAULT NULL,
  PRIMARY KEY (`Book_ID`,`Programme_ID`),
  KEY `Programme_ID` (`Programme_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- RELATIONSHIPS FOR TABLE `book_copies`:
--   `Book_ID`
--       `book` -> `Book_ID`
--   `Programme_ID`
--       `library_progarmme` -> `Programme_ID`
-- Dumping data for table `book_copies`
INSERT INTO `book_copies` (`Book_ID`, `Programme_ID`, `No_of_Copies`) VALUES
(2, 101, 20);


DROP TABLE IF EXISTS `book_lending`;
CREATE TABLE IF NOT EXISTS `book_lending` (
  `Book_ID` int(11) NOT NULL,
  `Programme_ID` int(11) NOT NULL,
  `Card_No` int(11) NOT NULL,
  `Date_Out` date DEFAULT NULL,
  `Due_Date` date DEFAULT NULL,
  PRIMARY KEY (`Book_ID`,`Programme_ID`,`Card_No`),
  KEY `Programme_ID` (`Programme_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- RELATIONSHIPS FOR TABLE `book_lending`:
--   `Book_ID`
--       `book` -> `Book_ID`
--   `Programme_ID`
--       `library_progarmme` -> `Programme_ID`
-- Dumping data for table `book_lending`
INSERT INTO `book_lending` (`Book_ID`, `Programme_ID`, `Card_No`, `Date_Out`, `Due_Date`) VALUES
(2, 101, 501, '2017-02-01', '2017-02-20');

-- Table structure for table `card`
DROP TABLE IF EXISTS `card`;
CREATE TABLE IF NOT EXISTS `card` (
  `Card_No` int(11) NOT NULL,
  PRIMARY KEY (`Card_No`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- RELATIONSHIPS FOR TABLE `card`:
-- Dumping data for table `card`
INSERT INTO `card` (`Card_No`) VALUES
(500),
(501);

-- Table structure for table `library_progarmme`
DROP TABLE IF EXISTS `library_progarmme`;
CREATE TABLE IF NOT EXISTS `library_progarmme` (
  `Programme_ID` int(11) NOT NULL,
  `Programme_Name` varchar(30) DEFAULT NULL,
  `Address` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Programme_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- RELATIONSHIPS FOR TABLE `library_progarmme`:
-- Dumping data for table `library_progarmme`
INSERT INTO `library_progarmme` (`Programme_ID`, `Programme_Name`, `Address`) VALUES
(100, 'Computers', 'Mysore'),
(101, 'QSpiders', 'Bangalore');

-- Table structure for table `publisher`
DROP TABLE IF EXISTS `publisher`;
CREATE TABLE IF NOT EXISTS `publisher` (
  `Name` varchar(30) NOT NULL,
  `Phone` int(11) DEFAULT NULL,
  `Address` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- RELATIONSHIPS FOR TABLE `publisher`:
-- Dumping data for table `publisher`
INSERT INTO `publisher` (`Name`, `Phone`, `Address`) VALUES
('Mehwish', 9414141, 'Mysore'),
('Suhani', 9212121, 'Bangalore');

-- Stand-in structure for view `v_books`
-- (See below for the actual view)
--
DROP VIEW IF EXISTS `v_books`;
CREATE TABLE IF NOT EXISTS `v_books` (
`Book_ID` int(11)
,`Title` varchar(20)
,`No_of_Copies` int(11)
);

-- Stand-in structure for view `v_publication`
-- (See below for the actual view)
DROP VIEW IF EXISTS `v_publication`;
CREATE TABLE IF NOT EXISTS `v_publication` (
`Publication_Year` varchar(20)
);

-- Structure for view `v_books`
DROP TABLE IF EXISTS `v_books`;

DROP VIEW IF EXISTS `v_books`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_books`  AS SELECT `b`.`Book_ID` AS `Book_ID`, `b`.`Title` AS `Title`, `c`.`No_of_Copies` AS `No_of_Copies` FROM ((`book` `b` join `book_copies` `c`) join `library_progarmme` `l`) WHERE `b`.`Book_ID` = `c`.`Book_ID` AND `l`.`Programme_ID` = `c`.`Programme_ID` ;

-- Structure for view `v_publication`
--
DROP TABLE IF EXISTS `v_publication`;

DROP VIEW IF EXISTS `v_publication`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_publication`  AS SELECT `book`.`Publication_Year` AS `Publication_Year` FROM `book` ;

-- Constraints for dumped tables
-- Constraints for table `book`
ALTER TABLE `book`
  ADD CONSTRAINT `book_ibfk_1` FOREIGN KEY (`Publisher__Name`) REFERENCES `publisher` (`Name`) ON DELETE CASCADE;

-- Constraints for table `book_authors`
ALTER TABLE `book_authors`
  ADD CONSTRAINT `book_authors_ibfk_1` FOREIGN KEY (`Book_ID`) REFERENCES `book` (`Book_ID`) ON DELETE CASCADE;

-- Constraints for table `book_copies`
--
ALTER TABLE `book_copies`
  ADD CONSTRAINT `book_copies_ibfk_1` FOREIGN KEY (`Book_ID`) REFERENCES `book` (`Book_ID`) ON DELETE CASCADE,
  ADD CONSTRAINT `book_copies_ibfk_2` FOREIGN KEY (`Programme_ID`) REFERENCES `library_progarmme` (`Programme_ID`) ON DELETE CASCADE;
-- Constraints for table `book_lending`
--
ALTER TABLE `book_lending`
  ADD CONSTRAINT `book_lending_ibfk_1` FOREIGN KEY (`Book_ID`) REFERENCES `book` (`Book_ID`) ON DELETE CASCADE,
  ADD CONSTRAINT `book_lending_ibfk_2` FOREIGN KEY (`Programme_ID`) REFERENCES `library_progarmme` (`Programme_ID`) ON DELETE CASCADE;
COMMIT;