-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 21, 2024 at 01:55 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

-- Database: `movie`
--
CREATE DATABASE IF NOT EXISTS `movie` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `movie`;
--
-- Table structure for table `actor`
--
CREATE TABLE `actor` (
  `Act_id` int(11) NOT NULL,
  `Act_Name` varchar(25) NOT NULL,
  `Act_Gender` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
--
-- Dumping data for table `actor`
--
INSERT INTO `actor` (`Act_id`, `Act_Name`, `Act_Gender`) VALUES
(301, 'Anushka', 'F'),
(302, 'Prabhas', 'M'),
(303, 'Siddharth', 'M'),
(304, 'Sushant', 'M');
-- --------------------------------------------------------
--
-- Table structure for table `director`
--
CREATE TABLE `director` (
  `Dir_id` int(11) NOT NULL,
  `Dir_Name` varchar(25) NOT NULL,
  `Dir_Phone` char(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
--
-- Dumping data for table `director`
--
INSERT INTO `director` (`Dir_id`, `Dir_Name`, `Dir_Phone`) VALUES
(60, 'Rajamouli', '9212121212'),
(61, 'Hitchcock', '9414141414'),
(62, 'Faran', '9616161616'),
(63, 'Steven Spielberg', '9818181818');
-- --------------------------------------------------------
--
-- Table structure for table `movies`
--
CREATE TABLE `movies` (
  `Mov_id` int(11) NOT NULL,
  `Mov_Year` year(4) NOT NULL,
  `Mov_Lang` varchar(15) NOT NULL,
  `Dir_id` int(11) NOT NULL,
  `Mov_Title` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
--
-- Dumping data for table `movies`
--
INSERT INTO `movies` (`Mov_id`, `Mov_Year`, `Mov_Lang`, `Dir_id`, `Mov_Title`) VALUES
(1001, '2017', 'Telugu', 60, 'Bahubali-2'),
(1002, '2015', 'Telugu', 61, 'Bahubali-1'),
(1003, '2023', 'Hindi', 62, 'Animal'),
(1004, '2011', 'English', 62, 'War Horse');
-- --------------------------------------------------------
--
-- Table structure for table `movie_cast`
--
CREATE TABLE `movie_cast` (
  `Act_id` int(11) NOT NULL,
  `Mov_id` int(11) NOT NULL,
  `Role` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
--
-- Dumping data for table `movie_cast`
--
INSERT INTO `movie_cast` (`Act_id`, `Mov_id`, `Role`) VALUES
(301, 1001, 'Heroine'),
(301, 1002, 'Heroine'),
(301, 1003, 'Hero'),
(303, 1002, 'Guest'),
(304, 1004, 'Son');
-- --------------------------------------------------------
--
-- Table structure for table `rating`
--
CREATE TABLE `rating` (
  `Mov_id` int(11) DEFAULT NULL,
  `Rev_Stars` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
--
-- Dumping data for table `rating`
--
INSERT INTO `rating` (`Mov_id`, `Rev_Stars`) VALUES
(1001, 4),
(1002, 5),
(1003, 3),
(1004, 4);
--
-- Indexes for dumped tables
--
-- Indexes for table `actor`
--
ALTER TABLE `actor`
  ADD PRIMARY KEY (`Act_id`);
--
-- Indexes for table `director`
--
ALTER TABLE `director`
  ADD PRIMARY KEY (`Dir_id`);
--
-- Indexes for table `movies`
--
ALTER TABLE `movies`
  ADD PRIMARY KEY (`Mov_id`),
  ADD KEY `Dir_id` (`Dir_id`);
--
-- Indexes for table `movie_cast`
--
ALTER TABLE `movie_cast`
  ADD PRIMARY KEY (`Act_id`,`Mov_id`),
  ADD KEY `Mov_id` (`Mov_id`);
--
-- Indexes for table `rating`
--
ALTER TABLE `rating`
  ADD KEY `Mov_id` (`Mov_id`);
--
-- Constraints for dumped tables
--
-- Constraints for table `movies`
--
ALTER TABLE `movies`
  ADD CONSTRAINT `movies_ibfk_1` FOREIGN KEY (`Dir_id`) REFERENCES `director` (`Dir_id`);
--
-- Constraints for table `movie_cast`
--
ALTER TABLE `movie_cast`
  ADD CONSTRAINT `movie_cast_ibfk_1` FOREIGN KEY (`Act_id`) REFERENCES `actor` (`Act_id`),
  ADD CONSTRAINT `movie_cast_ibfk_2` FOREIGN KEY (`Mov_id`) REFERENCES `movies` (`Mov_id`);
--
-- Constraints for table `rating`
--
ALTER TABLE `rating`
  ADD CONSTRAINT `rating_ibfk_1` FOREIGN KEY (`Mov_id`) REFERENCES `movies` (`Mov_id`);