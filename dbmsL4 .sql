-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 22, 2024 at 02:13 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `college`
--
CREATE DATABASE IF NOT EXISTS `college` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `college`;

-- --------------------------------------------------------

--
-- Table structure for table `class`
--

CREATE TABLE `class` (
  `USN` char(10) NOT NULL,
  `SSID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `class`
--

INSERT INTO `class` (`USN`, `SSID`) VALUES
('1BI15CS101', 1),
('1BI15CS105', 1),
('1BI15CS102', 2),
('1BI15CS103', 3),
('1BI15CS104', 4);

-- --------------------------------------------------------

--
-- Table structure for table `course`
--

CREATE TABLE `course` (
  `Subcode` char(7) NOT NULL,
  `Title` varchar(20) DEFAULT NULL,
  `Sem` int(11) DEFAULT NULL,
  `CREDITS` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `course`
--

INSERT INTO `course` (`Subcode`, `Title`, `Sem`, `CREDITS`) VALUES
('21CS41', 'MAT', 4, 3),
('21CS81', 'DataScience', 8, 4),
('21CS82', 'CloudComputing', 8, 4),
('21CS83', 'CyberSecurity', 8, 4),
('21CS84', 'AIML', 8, 4);

-- --------------------------------------------------------

--
-- Table structure for table `iamarks`
--

CREATE TABLE `iamarks` (
  `USN` char(10) NOT NULL,
  `Subcode` char(7) NOT NULL,
  `SSID` int(11) NOT NULL,
  `Test1` int(11) NOT NULL,
  `Test2` int(11) NOT NULL,
  `Test3` int(11) NOT NULL,
  `FinalIA` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `iamarks`
--

INSERT INTO `iamarks` (`USN`, `Subcode`, `SSID`, `Test1`, `Test2`, `Test3`, `FinalIA`) VALUES
('1BI15CS101', '21CS41', 1, 18, 19, 20, 19.5),
('1BI15CS102', '21CS81', 2, 15, 16, 14, 15.5),
('1BI15CS103', '21CS82', 3, 11, 10, 12, 11.5),
('1BI15CS104', '21CS83', 4, 20, 19, 18, 19.5),
('1BI15CS105', '21CS84', 1, 14, 15, 16, 15.5);

-- --------------------------------------------------------

--
-- Table structure for table `semsec`
--

CREATE TABLE `semsec` (
  `SSID` int(11) NOT NULL,
  `Sem` varchar(5) DEFAULT NULL,
  `Sec` varchar(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `semsec`
--

INSERT INTO `semsec` (`SSID`, `Sem`, `Sec`) VALUES
(1, '4', 'C'),
(2, '8', 'A'),
(3, '8', 'B'),
(4, '8', 'C');

-- --------------------------------------------------------

--
-- Table structure for table `student`
--

CREATE TABLE `student` (
  `USN` char(10) NOT NULL,
  `SName` varchar(25) NOT NULL,
  `Address` varchar(30) NOT NULL,
  `Phone` varchar(10) DEFAULT NULL,
  `Gender` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `student`
--

INSERT INTO `student` (`USN`, `SName`, `Address`, `Phone`, `Gender`) VALUES
('1BI15CS101', 'John', 'New York', '1234567890', 'M'),
('1BI15CS102', 'Emma', 'Los Angeles', '2345678901', 'F'),
('1BI15CS103', 'David', 'Chicago', '3456789012', 'M'),
('1BI15CS104', 'Olivia', 'Houston', '4567890123', 'F'),
('1BI15CS105', 'Michael', 'Philadelphia', '5678901234', 'M');

-- --------------------------------------------------------

--
-- Stand-in structure for view `studentmarks`
-- (See below for the actual view)
--
CREATE TABLE `studentmarks` (
`Subcode` char(7)
,`Test1` int(11)
);

-- --------------------------------------------------------

--
-- Structure for view `studentmarks`
--
DROP TABLE IF EXISTS `studentmarks`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `studentmarks`  AS SELECT `iamarks`.`Subcode` AS `Subcode`, `iamarks`.`Test1` AS `Test1` FROM `iamarks` WHERE `iamarks`.`USN` = '1BI15CS101' ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `class`
--
ALTER TABLE `class`
  ADD PRIMARY KEY (`USN`),
  ADD KEY `SSID` (`SSID`);

--
-- Indexes for table `course`
--
ALTER TABLE `course`
  ADD PRIMARY KEY (`Subcode`);

--
-- Indexes for table `iamarks`
--
ALTER TABLE `iamarks`
  ADD PRIMARY KEY (`USN`,`Subcode`,`SSID`),
  ADD KEY `Subcode` (`Subcode`),
  ADD KEY `SSID` (`SSID`);

--
-- Indexes for table `semsec`
--
ALTER TABLE `semsec`
  ADD PRIMARY KEY (`SSID`);

--
-- Indexes for table `student`
--
ALTER TABLE `student`
  ADD PRIMARY KEY (`USN`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `class`
--
ALTER TABLE `class`
  ADD CONSTRAINT `class_ibfk_1` FOREIGN KEY (`USN`) REFERENCES `student` (`USN`),
  ADD CONSTRAINT `class_ibfk_2` FOREIGN KEY (`SSID`) REFERENCES `semsec` (`SSID`);

--
-- Constraints for table `iamarks`
--
ALTER TABLE `iamarks`
  ADD CONSTRAINT `iamarks_ibfk_1` FOREIGN KEY (`USN`) REFERENCES `student` (`USN`),
  ADD CONSTRAINT `iamarks_ibfk_2` FOREIGN KEY (`Subcode`) REFERENCES `course` (`Subcode`),
  ADD CONSTRAINT `iamarks_ibfk_3` FOREIGN KEY (`SSID`) REFERENCES `semsec` (`SSID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
