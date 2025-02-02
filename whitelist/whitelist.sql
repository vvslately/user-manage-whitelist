-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 02, 2025 at 12:21 PM
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
-- Database: `whitelist`
--

-- --------------------------------------------------------

--
-- Table structure for table `key_management`
--

CREATE TABLE `key_management` (
  `key_id` int(11) NOT NULL,
  `user_key` varchar(255) NOT NULL,
  `user_hwid` varchar(255) NOT NULL,
  `user_id` varchar(255) NOT NULL,
  `status` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `key_management`
--

INSERT INTO `key_management` (`key_id`, `user_key`, `user_hwid`, `user_id`, `status`) VALUES
(2, 'death', 'cae5b0b8-ccf1-11ef-b04d-806e6f6e6963', 'ddosama', 'used'),
(3, 'death2', 'cae5b0b8-ccf1-11ef-b04d-806e6f6e6963', '', 'used'),
(4, 'death3', 'cae5b0b8-ccf1-11ef-b04d-806e6f6e6963', '', 'used');

-- --------------------------------------------------------

--
-- Table structure for table `player`
--

CREATE TABLE `player` (
  `player_id` int(11) NOT NULL,
  `player_name` varchar(255) NOT NULL,
  `player_gems` int(11) NOT NULL,
  `player_gold` int(11) NOT NULL,
  `player_star` int(11) NOT NULL,
  `player_key` varchar(255) NOT NULL,
  `player_status` varchar(255) NOT NULL DEFAULT 'offline'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `player`
--

INSERT INTO `player` (`player_id`, `player_name`, `player_gems`, `player_gold`, `player_star`, `player_key`, `player_status`) VALUES
(1, 'toocute043', 1234, 500, 10, 'death', ''),
(2, 'adadad', 1234, 500, 10, 'death', ''),
(3, 'chook13456', 987, 465, 0, 'death', ''),
(4, 'koykapom12345', 177, 3050, 150, 'death3', 'offline');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `key_management`
--
ALTER TABLE `key_management`
  ADD PRIMARY KEY (`key_id`);

--
-- Indexes for table `player`
--
ALTER TABLE `player`
  ADD PRIMARY KEY (`player_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `key_management`
--
ALTER TABLE `key_management`
  MODIFY `key_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `player`
--
ALTER TABLE `player`
  MODIFY `player_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
