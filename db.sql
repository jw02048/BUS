DROP DATABASE IF EXISTS busdb;

CREATE DATABASE busdb;

USE busdb;


CREATE TABLE bus(
    id INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    totalSeat INT(10) NOT NULL,
    PRIMARY KEY(id)
);

CREATE TABLE line(
    id INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    `departure` VARCHAR(100) NOT NULL,
    `destination` VARCHAR(100) NOT NULL,
    charge INT(10) NOT NULL,
    PRIMARY KEY(id)
);

CREATE TABLE service(
    id INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    `departureTime` VARCHAR(100) NOT NULL,
    `estimatedTime` VARCHAR(100) NOT NULL,
    busId INT(10) NOT NULL,
    lineId INT(10) NOT NULL,
    PRIMARY KEY(id)
);




CREATE TABLE ticket(
    id INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    ticketCode CHAR(100) NOT NULL,
    `departureDate` VARCHAR(100) NOT NULL,
    serviceId INT(10) NOT NULL,
    seatNum INT(10) NOT NULL,
    memberId INT(10) NOT NULL,
    email VARCHAR(100) NOT NULL,
    charge INT(10) NOT NULL,
    PRIMARY KEY(id)
);


CREATE TABLE MEMBER(
    id INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    `name` VARCHAR(100) NOT NULL,
    `loginId` VARCHAR(100) NOT NULL,
    `loginPw` VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    emailAuthKey CHAR(100) NOT NULL,
    emailAuthStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0,
    delStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0,
    permissionLevel TINYINT(1) UNSIGNED NOT NULL DEFAULT 0,
    PRIMARY KEY(id)
);

SELECT *
FROM bus;

INSERT INTO bus (regDate, totalSeat) VALUES (NOW(),28);
INSERT INTO bus (regDate, totalSeat) VALUES (NOW(),28);
INSERT INTO bus (regDate, totalSeat) VALUES (NOW(),28);
INSERT INTO bus (regDate, totalSeat) VALUES (NOW(),28);

SELECT *
FROM line;

INSERT INTO line (regDate, `departure`, `destination`, charge) VALUES (NOW(),"서울","대전",10000);
INSERT INTO line (regDate, `departure`, `destination`, charge) VALUES (NOW(),"대전","서울",10000);

SELECT *
FROM service;

INSERT INTO service (regDate, `departureTime`, `estimatedTime`, busId, lineId) VALUES (NOW(),"12:00","2",1,1);
INSERT INTO service (regDate, `departureTime`, `estimatedTime`, busId, lineId) VALUES (NOW(),"16:00","2",2,1);
INSERT INTO service (regDate, `departureTime`, `estimatedTime`, busId, lineId) VALUES (NOW(),"12:00","2",3,2);
INSERT INTO service (regDate, `departureTime`, `estimatedTime`, busId, lineId) VALUES (NOW(),"16:00","2",4,2);

SELECT *
FROM ticket;

INSERT INTO ticket (regDate, `ticketCode`, `departureDate`, serviceId, seatNum, memberId, email, charge) VALUES (NOW(),"abcd","2019-08-20",1,1,1,"test@gmail.com",10000);
INSERT INTO ticket (regDate, `ticketCode`, `departureDate`, serviceId, seatNum, memberId, email, charge) VALUES (NOW(),"abce","2019-08-20",1,3,1,"test@gmail.com",10000);
INSERT INTO ticket (regDate, `ticketCode`, `departureDate`, serviceId, seatNum, memberId, email, charge) VALUES (NOW(),"abcf","2019-08-20",1,4,1,"test@gmail.com",10000);
INSERT INTO ticket (regDate, `ticketCode`, `departureDate`, serviceId, seatNum, memberId, email, charge) VALUES (NOW(),"abcg","2019-08-21",2,10,1,"test@gmail.com",10000);
INSERT INTO ticket (regDate, `ticketCode`, `departureDate`, serviceId, seatNum, memberId, email, charge) VALUES (NOW(),"abch","2019-08-21",3,5,1,"test@gmail.com",10000);




SELECT *
FROM `member`;

INSERT INTO `member` (regDate, `name`, `loginId`, `loginPw`, email, emailAuthKey, emailAuthStatus, delStatus, permissionLevel) VALUES (NOW(), "홍길동", "user1","user1", "a", "a", 1, 0, 1);
