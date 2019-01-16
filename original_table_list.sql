clear screen;

DROP TABLE commenta CASCADE CONSTRAINTS;



CREATE TABLE commenta (
	conum number, 
	unum number,
	cnum number,
	co varchar2(30),
	PRIMARY KEY(conum),
        CONSTRAINT fk_com2
    	FOREIGN KEY (cnum)
    	REFERENCES selectionCart (cnum),
    	CONSTRAINT fk_com1
    	FOREIGN KEY (unum)
    	REFERENCES userInfo (unum)
	);


clear screen;

DROP TABLE userInfo CASCADE CONSTRAINTS;


CREATE TABLE userInfo (
	unum number, 
	uname varchar2(20), 
	age number,
	phone number,
	pass varchar2(20),
	lnum number,
        PRIMARY KEY(unum),
        CONSTRAINT fk_uinfo
    	FOREIGN KEY (lnum)
    	REFERENCES location (lnum)); 

clear screen;

 DROP TABLE ratings CASCADE CONSTRAINTS;


CREATE TABLE ratings (
	rtnum number, 
	unum number, 
	rnum number,
	mnum number,
	rating number,
	PRIMARY KEY (rtnum),
	CONSTRAINT fk_rt1 FOREIGN KEY (rnum) REFERENCES restaurant (rnum),
	CONSTRAINT fk_rt3 FOREIGN KEY (unum) REFERENCES userInfo (unum),
	CONSTRAINT fk_rt2 FOREIGN KEY (mnum) REFERENCES menu (mnum));

clear screen;

--DROP TABLE location CASCADE CONSTRAINTS;


CREATE TABLE food_type (
	fnum number, 
	fname varchar2(30),
	PRIMARY KEY(fnum)); 

clear screen;

DROP TABLE location CASCADE CONSTRAINTS;


CREATE TABLE location (
	lnum number, 
	lname varchar2(30),
	PRIMARY KEY(lnum)); 


clear screen;

--DROP TABLE res CASCADE CONSTRAINTS;


CREATE TABLE restaurant (
	rnum number, 
	rname varchar2(30), 
	lnum number, 
	PRIMARY KEY (rnum),
	CONSTRAINT fk_res
    FOREIGN KEY (lnum)
    REFERENCES location (lnum)); 


clear screen;

DROP TABLE menu CASCADE CONSTRAINTS;


CREATE TABLE menu (
	mnum number, 
	mname varchar2(30), 
	price integer,
	rnum number,
	fnum number,
	PRIMARY KEY (mnum),
	CONSTRAINT fk_m1 FOREIGN KEY (rnum) REFERENCES restaurant (rnum),
	CONSTRAINT fk_m2 FOREIGN KEY (fnum) REFERENCES food_type (fnum));


clear screen;

--DROP TABLE selectionCart CASCADE CONSTRAINTS;


CREATE TABLE selectionCart (
	cnum number, 
	unum number,
	mnum number,
	count number,
	price integer,
        PRIMARY KEY(cnum),
        CONSTRAINT fk_sc1
    	FOREIGN KEY (unum)
    	REFERENCES userInfo (unum),
	CONSTRAINT fk_sc2
    	FOREIGN KEY (mnum)
    	REFERENCES menu (mnum)); 



clear screen;

drop table quality_prediction cascade constraints;

CREATE TABLE quality_prediction (
   id int,
   res_id number,
   price number,
   duration number,
   rating number,
   quality number
);

INSERT INTO quality_prediction values(1,1,1550,12,1,1);
INSERT INTO quality_prediction values(2,2,2250,16,5,3);
INSERT INTO quality_prediction values(3,3,3350,19,3,2);
INSERT INTO quality_prediction values(4,4,2850,20,4,3);
INSERT INTO quality_prediction values(5,5,1250,24,3,2);
INSERT INTO quality_prediction values(6,6,7850,8,2,3);
INSERT INTO quality_prediction values(7,7,4350,30,2,2);
INSERT INTO quality_prediction values(8,8,5350,28,4,3);
INSERT INTO quality_prediction values(9,9,3650,25,2,2);
INSERT INTO quality_prediction values(10,10,3750,22,2,1);
INSERT INTO quality_prediction values(11,11,8350,18,2,2);
INSERT INTO quality_prediction values(12,12,9350,38,4,3);
INSERT INTO quality_prediction values(13,13,1050,40,2,1);
INSERT INTO quality_prediction values(14,14,1150,57,3,2);
INSERT INTO quality_prediction values(15,15,1278,89,5,3);
INSERT INTO quality_prediction values(16,16,1312,14,2,1);
INSERT INTO quality_prediction values(17,17,6791,67,5,3);
INSERT INTO quality_prediction values(18,18,9013,56,3,2);
INSERT INTO quality_prediction values(19,19,4712,45,2,1);
INSERT INTO quality_prediction values(20,20,1535,30,3,2);
INSERT INTO quality_prediction values(21,21,6453,37,5,3);
INSERT INTO quality_prediction values(22,22,5432,48,2,1);
INSERT INTO quality_prediction values(23,23,5493,36,3,2);
INSERT INTO quality_prediction values(24,24,4732,27,5,3);


commit;
