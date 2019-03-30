-- phpMyAdmin SQL Dump
-- version 3.4.10.1deb1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Dec 03, 2013 at 03:03 PM
-- Server version: 5.5.34
-- PHP Version: 5.3.10-1ubuntu3.8
-- https://github.com/peredurabefrog/phpSecureLogin
SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `RAILWAY_MANAGEMENT`
--

-- --------------------------------------------------------

--
-- Table structure for table `login_attempts`
--

CREATE TABLE IF NOT EXISTS `login_attempts` (
  `user_id` int(11) NOT NULL,
  `time` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `login_attempts`
--

INSERT INTO `login_attempts` (`user_id`, `time`) VALUES
(1, '1385995353'),
(1, '1386011064');

-- --------------------------------------------------------

--
-- Table structure for table `members`
--

CREATE TABLE IF NOT EXISTS `members` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(30) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` char(128) NOT NULL,
  `salt` char(128) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `members`
--

INSERT INTO `members` (`id`, `username`, `email`, `password`, `salt`) VALUES
(1, 'test_user', 'test@example.com', '00807432eae173f652f2064bdca1b61b290b52d40e429a7d295d76a71084aa96c0233b82f1feac45529e0726559645acaed6f3ae58a286b9f075916ebf66cacc', 'f9aab579fc1b41ed0c44fe4ecdbfcdb4cb99b9023abb241a6db833288f4eea3c02f76e0d35204a8695077dcf81932aa59006423976224be0390395bae152d4ef');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
CREATE TABLE STATIONS(
Station_no int PRIMARY KEY,
Station_name varchar(30),
City varchar(30),
Station_master varchar(30),
no_of_platforms int
);

CREATE TABLE COACH_DETAILS(
Coach_Type varchar(10) PRIMARY KEY,
AC BOOLEAN,
Nature_of_coach varchar(10) CHECK(Nature_of_coach IN ("Seater","Sleeper","Goods","Pantry")),
Layout_no int,
Total_available_seats int
);

INSERT INTO COACH_DETAILS values("CC",true,"Seater",1,80);
INSERT INTO COACH_DETAILS values("EC",true,"Seater",2,80);
INSERT INTO COACH_DETAILS values("3AC",true,"Sleeper",3,40);
INSERT INTO COACH_DETAILS values("2AC",true,"Sleeper",4,30);
INSERT INTO COACH_DETAILS values("1AC",true,"Sleeper",5,20);
INSERT INTO COACH_DETAILS values("SL",false,"Sleeper",3,40);
INSERT INTO COACH_DETAILS values("GN",false,"Sleeper",3,40);
INSERT INTO COACH_DETAILS values("2S",false,"Seater",1,80);
INSERT INTO COACH_DETAILS values("Pantry",false,"Pantry",6,0);
INSERT INTO COACH_DETAILS values("Goods",false,"Goods",6,0);

CREATE TABLE TRAIN_INFO(
Train_no int PRIMARY KEY,
Train_name varchar(30),
Source_station_no int,
Destination_station_no int,
Distance int,
Track_type varchar(30) CHECK(Track_type IN('Broad_gauge','Narrow_gauge')),
FOREIGN key(Source_station_no) REFERENCES STATIONS(Station_no) ON UPDATE CASCADE ON DELETE CASCADE,
FOREIGN key(Destination_station_no) REFERENCES STATIONS(Station_no) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE TRAIN_SCHEDULE(
Train_no int PRIMARY KEY,
Coach_1_quantity int,Coach_1_price int,
Coach_2_quantity int,Coach_2_price int,
Coach_3_quantity int,Coach_3_price int,
Coach_4_quantity int,Coach_4_price int,
Coach_5_quantity int,Coach_5_price int,
Coach_6_quantity int,Coach_6_price int,
Coach_7_quantity int,Coach_7_price int,
Coach_8_quantity int,Coach_8_price int,
FOREIGN key(Train_no) REFERENCES TRAIN_INFO(Train_no) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE RAILWAY_PATH(
Train_no int,
Station_no int, 
previous_station_no int,
Distance int,
Sequence_number int,
Arrival_time time,
Departure_time time,
Monday_avail boolean,
Tuesday_avail boolean,
Wednesday_avail boolean,
Thursday_avail boolean,
Friday_avail boolean,
Saturday_avail boolean,
Sunday_avail boolean,
Day_offset int,
PRIMARY KEY(Train_no,Station_no),
FOREIGN key(Station_no) REFERENCES STATIONS(Station_no) ON UPDATE CASCADE ON DELETE CASCADE,
FOREIGN key(previous_station_no) REFERENCES STATIONS(Station_no) ON UPDATE CASCADE ON DELETE CASCADE,
FOREIGN key(Train_no) REFERENCES TRAIN_INFO(Train_no) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE ALL_POSSIBLE_PATHS(
Station_no_1 int,
Station_no_2 int,
PRIMARY KEY(Station_no_2,Station_no_1),
FOREIGN key(Station_no_1) REFERENCES STATIONS(Station_no) ON UPDATE CASCADE ON DELETE CASCADE,
FOREIGN key(station_no_2) REFERENCES STATIONS(Station_no) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE TICKET_AVAILABLITY(
Train_no int,
Date DATE,
Coach_Type varchar(10),
Station_no int,
Total_available_seats int,
PRIMARY KEY(Train_no,Date,Coach_Type,Station_no),
FOREIGN key(Train_no) REFERENCES TRAIN_INFO(Train_no) ON UPDATE CASCADE ON DELETE CASCADE,
FOREIGN key(Station_no) REFERENCES STATIONS(Station_no) ON UPDATE CASCADE ON DELETE CASCADE,
FOREIGN key(Coach_Type) REFERENCES COACH_DETAILS(Coach_Type) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE BOOKING(
PNR_no int PRIMARY KEY,
Username varchar(30),
Name varchar(30),
Age int,
DOB DATE,
Gender varchar(10) CHECK(Gender in ('M','F','Other')),
Insurance_AV int,
Train_no int,
Coach_Type varchar(10),
Coach_no int,
Seat_no int,
Source_station_no int,
Destination_station_no int,
Boarding_Date DATE,
Booking_Status varchar(10),
FOREIGN key(Coach_Type) REFERENCES COACH_DETAILS(Coach_Type) ON UPDATE CASCADE ON DELETE CASCADE,
FOREIGN key(Train_no) REFERENCES TRAIN_INFO(Train_no) ON UPDATE CASCADE ON DELETE CASCADE,
FOREIGN key(Source_station_no) REFERENCES STATIONS(Station_no) ON UPDATE CASCADE ON DELETE CASCADE,
FOREIGN key(Destination_station_no) REFERENCES STATIONS(Station_no) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE OVERALL_WAITING(
PNR_no int,
Train_no int,
Dates DATE,
Coach_Type varchar(10),
WL_no int,
PRIMARY KEY(Train_no,Dates,Coach_Type,WL_no),
FOREIGN key(Coach_Type) REFERENCES COACH_DETAILS(Coach_Type) ON UPDATE CASCADE ON DELETE CASCADE,
FOREIGN key(Train_no) REFERENCES TRAIN_INFO(Train_no) ON UPDATE CASCADE ON DELETE CASCADE,
FOREIGN key(PNR_no) REFERENCES BOOKING(PNR_no) ON UPDATE CASCADE ON DELETE CASCADE
);

DELIMITER //
CREATE TRIGGER railway_graph_check BEFORE INSERT ON RAILWAY_PATH
FOR EACH ROW BEGIN
IF (NEW.previous_station_no IS NOT NULL) AND (SELECT A.Station_no_1 from ALL_POSSIBLE_PATHS as A  where  (A.Station_no_1=NEW.Station_no and A.Station_no_2 = NEW.previous_station_no) OR (A.Station_no_2=NEW.Station_no and A.Station_no_1 = NEW.previous_station_no)) IS NULL THEN
SET NEW.Train_no=NULL;
SET NEW.Station_no=NULL;
END IF;
END;//
DELIMITER ;

insert into STATIONS values(1,"NDLS","Delhi","siddharth",12);
insert into STATIONS values(2,"GZB","Ghaziabad","raghav",12);
insert into STATIONS values(3,"CNB","Kanpur","chandani",10);
insert into STATIONS values(4,"LJN","Lucknow","yash",12);

insert into ALL_POSSIBLE_PATHS values(1,2);
insert into ALL_POSSIBLE_PATHS values(2,3);
insert into ALL_POSSIBLE_PATHS values(3,4);
insert into ALL_POSSIBLE_PATHS values(1,3);
insert into ALL_POSSIBLE_PATHS values(1,4);
insert into ALL_POSSIBLE_PATHS values(2,4);

insert into TRAIN_INFO values(12004,"Shatabdi",1,4,500,"Broad_gauge");
insert into TRAIN_INFO values(12003,"Shatabdi",4,1,500,"Broad_gauge");
insert into TRAIN_INFO values(12034,"Shatabdi",3,1,450,"Broad_gauge");

insert into RAILWAY_PATH values(12004,1,NULL,0,1,"6:30:00","6:30:00",true,true,true,true,true,true,true,0);
insert into RAILWAY_PATH values(12004,2,1,100,2,"6:48:00","6:55:00",true,true,true,true,true,true,true,0);
insert into RAILWAY_PATH values(12004,3,2,450,3,"11:20:00","11:25:00",true,true,true,true,true,true,true,0);
insert into RAILWAY_PATH values(12004,4,3,500,4,"12:30:00","12:30:00",true,true,true,true,true,true,true,0);
insert into RAILWAY_PATH values(12034,3,NULL,0,1,"4:50:00","4:50:00",true,true,true,true,true,true,true,0);
insert into RAILWAY_PATH values(12034,1,3,450,2,"8:50:00","8:50:00",true,true,true,true,true,true,true,0);