

--Step 1: Creating a Database 

DROP DATABASE ATHLEISURE_STORE;

CREATE DATABASE ATHLEISURE_STORE
;

USE ATHLEISURE_STORE
;

--Step 2: Creating Tables

--Creating Address Table


CREATE TABLE ADDRESS_INFO
(
	ADDRESS_ID			INT			IDENTITY	CONSTRAINT	PK_ADDRESS_ID		PRIMARY KEY
	,STREET_ADDRESS		VARCHAR(85)				CONSTRAINT	NN_STREET_ADDRESS	NOT NULL
	,CITY				VARCHAR(20)				CONSTRAINT	NN_CITY				NOT NULL
	,STATE				VARCHAR(20)				CONSTRAINT	NN_STATE			NOT NULL
	,ZIPCODE			VARCHAR(9)				CONSTRAINT	NN_ZIPCODE			NOT NULL					
)
;


--Creating Shipper Table

CREATE TABLE SHIPPER
(
	SHIPPER_ID 			INT		     IDENTITY	CONSTRAINT PK_SHIPPER_ID 	 PRIMARY KEY
	,SHIPPER_NAME		VARCHAR(55)				CONSTRAINT NN_SHIPPER_NAME	 NOT NULL
	,SHIPPER_CITY		VARCHAR(20)				CONSTRAINT NN_SHIPPER_CITY	 NOT NULL
	,SHIPPER_PHONE		VARCHAR(15)				CONSTRAINT NN_SHIPPER_PHONE	 NOT NULL
	,SHIPPER_EMAIL		VARCHAR(100)			CONSTRAINT NN_SHIPPER_EMAIL	 NOT NULL
	,SHIPPER_REGION		VARCHAR(15)				CONSTRAINT NN_SHIPPER_REGION NOT NULL			
)
;

--Creating Customer Table

CREATE TABLE CUSTOMER
(
    CUSTOMER_ID             INT             IDENTITY       CONSTRAINT PK_CUSTOMERID      PRIMARY KEY
    ,CUSTOMER_NAME          VARCHAR(100)                   CONSTRAINT NN_CUSTOMERNAME	 NOT NULL
    ,CUSTOMER_ADDRESS_ID    INT			                   CONSTRAINT NN_CUSTOMERADDRESS NOT NULL
	,CONSTRAINT FK_C_ADDRESS_ID FOREIGN KEY (CUSTOMER_ADDRESS_ID) REFERENCES ADDRESS_INFO (ADDRESS_ID)
    ,CUSTOMER_PHONE         VARCHAR(15)                    CONSTRAINT NN_CUSTOMERPHONE   NOT NULL
    ,CUSTOMER_EMAIL         VARCHAR(100)                   CONSTRAINT NN_CUSTOMEREMAIL   NOT NULL
)
;


--Creating Supplier Table

CREATE TABLE SUPPLIER (
     SUPPLIER_ID			INT				IDENTITY	CONSTRAINT	PK_SUPPLIERID		PRIMARY KEY
    ,SUPPLIER_NAME			VARCHAR(255)				CONSTRAINT	NN_SUPPLIERNAME		NOT NULL
    ,SUPPLIER_ADDRESS_ID    INT							CONSTRAINT	NN_SUPPLIERADDRESS  NOT NULL
	,CONSTRAINT FK_S_ADDRESS_ID FOREIGN KEY (SUPPLIER_ADDRESS_ID) REFERENCES ADDRESS_INFO (ADDRESS_ID)
    ,SUPPLIER_PHONE			VARCHAR(15)				CONSTRAINT  NN_SUPPLIERPHONE		NOT NULL
    ,SUPPLIER_EMAIL         VARCHAR(255)				CONSTRAINT  NN_SUPPLIEREMAIL    NOT NULL
)
;



--Creating Product Table

CREATE TABLE PRODUCT 
(
    PRODUCT_ID			INT			IDENTITY	CONSTRAINT PK_PRODUCT_ID		PRIMARY KEY
    ,PRODUCT_NAME		VARCHAR(100)			CONSTRAINT NN_PRODUCT_NAME		NOT NULL
    ,PRODUCT_PRICE		MONEY					CONSTRAINT NN_PRODUCT_PRICE		NOT NULL
    ,PRODUCT_CATEGORY	VARCHAR(50)				CONSTRAINT NN_PRODUCT_CATEGORY	NOT NULL
    ,SUPPLIER_ID		INT						CONSTRAINT NN_SUPPLIER_ID		NOT NULL
	,CONSTRAINT FK_P_SUPPLIER_ID FOREIGN KEY (SUPPLIER_ID) REFERENCES SUPPLIER (SUPPLIER_ID)
    ,PRODUCT_COST 		MONEY					CONSTRAINT NN_PRODUCT_COST		NOT NULL
)
;


--Creating Purchase Order Table

CREATE TABLE PURCHASE_ORDER
(
   ORDER_ID				INT			IDENTITY	CONSTRAINT PK_ORDER_ID			PRIMARY KEY
   ,ORDER_DATE			DATE					CONSTRAINT NN_ORDER_DATE		NOT NULL
   ,ORDER_QUANTITY		INT						CONSTRAINT NN_ORDER_QUANTITY	NOT NULL
   ,TOTAL_AMOUNT		MONEY					CONSTRAINT NN_TOTAL_AMOUNT		NOT NULL
   ,ORDER_ADDRESS_ID	INT						CONSTRAINT NN_ORDER_ADDRESS_ID	NOT NULL
   ,CONSTRAINT FK_PU_ADDRESS_ID FOREIGN KEY (ORDER_ADDRESS_ID) REFERENCES ADDRESS_INFO (ADDRESS_ID)
   ,ORDER_PRODUCT_ID	INT						CONSTRAINT NN_ORDER_PRODUCT_ID	NOT NULL
   ,CONSTRAINT FK_PU_ORDER_PRODUCT_ID FOREIGN KEY (ORDER_PRODUCT_ID) REFERENCES PRODUCT (PRODUCT_ID)
     ,RECEIVED_DATE		DATE					CONSTRAINT NN_RECEIVED_DATE		NOT NULL
)
;

--Creating Department Table

CREATE TABLE DEPARTMENT
(
	DEPARTMENT_ID		INT			IDENTITY	CONSTRAINT	PK_DEPARTMENT_ID	PRIMARY KEY
	,DEPARTMENT_NAME	VARCHAR(30)				CONSTRAINT	NN_DEPARTMENT_NAME	NOT NULL
)
;

--Creating Job Profile Table

CREATE TABLE JOB_PROFILE
(
	JOB_ID				INT			IDENTITY	CONSTRAINT	PK_JOB_ID			PRIMARY KEY
	,DEPARTMENT_ID		INT						CONSTRAINT	NN_DEPARTMENT_ID	NOT NULL
	,CONSTRAINT FK_DEPARTMENT_ID FOREIGN KEY (DEPARTMENT_ID) REFERENCES DEPARTMENT(DEPARTMENT_ID)
	,JOB_NAME			VARCHAR(55)				CONSTRAINT	NN_JOB_NAME			NOT NULL
	,MIN_SALARY			MONEY					CONSTRAINT	NN_MIN_SALARY		NOT NULL
	,MAX_SALARY			MONEY					CONSTRAINT	NN_MAX_SALARY		NOT NULL
)
;

--Creating Employee Table

CREATE TABLE EMPLOYEE 
(
    EMPLOYEE_ID			INT			IDENTITY	CONSTRAINT PK_EMPLOYEE_ID		PRIMARY KEY
	,JOB_ID				INT						CONSTRAINT NN_JOB_ID			NOT NULL
	,CONSTRAINT FK_JOB_ID FOREIGN KEY (JOB_ID) REFERENCES JOB_PROFILE(JOB_ID)
	,FIRST_NAME			VARCHAR(50)				CONSTRAINT NN_FIRST_NAME		NOT NULL
    ,LAST_NAME			VARCHAR(50)				CONSTRAINT NN_LAST_NAME			NOT NULL
    ,ADDRESS_ID			INT						CONSTRAINT NN_ADDRESS_ID		NOT NULL
	,CONSTRAINT FK_EMP_ADDRESS_ID FOREIGN KEY (ADDRESS_ID) REFERENCES ADDRESS_INFO (ADDRESS_ID)
    ,EMPLOYEE_EMAIL		VARCHAR(100)			CONSTRAINT NN_EMPLOYEE_EMAIL	NOT NULL
    ,PHONE_NUMBER		VARCHAR(20)				CONSTRAINT NN_PHONE_NUMBER		NOT NULL
)
;

--Creating Employee PII Table

CREATE TABLE EMPLOYEEPII 
(
    EMPLOYEE_NAME	VARCHAR(100)			CONSTRAINT NN_NAME			NOT NULL
    ,EMPLOYEE_ID	INT			IDENTITY	CONSTRAINT NN_EMP_ID		NOT NULL
    ,DOB			DATE					CONSTRAINT NN_DOB			NOT NULL
    ,SSN			VARCHAR(15)				CONSTRAINT NN_SSN			NOT NULL
)
;



--Creating Customer Order Table

CREATE TABLE CUSTOMER_ORDER
(
   ORDER_ID				INT			IDENTITY	CONSTRAINT PK_CUST_ORDER_ID			PRIMARY KEY
   ,CUSTOMER_ID			INT						CONSTRAINT NN_CUSTOMER_ID		NOT NULL
   ,CONSTRAINT FK_ORDER_CUSTOMER_ID FOREIGN KEY (CUSTOMER_ID) REFERENCES CUSTOMER(CUSTOMER_ID)
   ,ORDER_DATE			DATE					CONSTRAINT NN_ORDER_DATE		NOT NULL
   ,ORDER_QUANTITY		INT						CONSTRAINT NN_ORDER_QUANTITY	NOT NULL
   ,TOTAL_AMOUNT		MONEY					CONSTRAINT NN_TOTAL_AMOUNT		NOT NULL
   ,ORDER_ADDRESS_ID	INT						CONSTRAINT NN_ORDER_ADDRESS_ID	NOT NULL
   ,CONSTRAINT FK_ORDER_ADDRESS_ID FOREIGN KEY (ORDER_ADDRESS_ID) REFERENCES ADDRESS_INFO (ADDRESS_ID)
   ,ORDER_EMPLOYEE_ID	INT						CONSTRAINT NN_ORDER_EMPLOYEE_ID	NOT NULL
   ,CONSTRAINT FK_ORDER_EMPLOYEE_ID FOREIGN KEY (ORDER_EMPLOYEE_ID) REFERENCES EMPLOYEE (EMPLOYEE_ID)
   ,ORDER_SHIPPER_ID	INT						CONSTRAINT NN_ORDER_SHIPPER_ID	NOT NULL
   ,CONSTRAINT FK_ORDER_SHIPPER_ID FOREIGN KEY (ORDER_SHIPPER_ID) REFERENCES SUPPLIER (SUPPLIER_ID)
)
;

--Creating Return Table

CREATE TABLE RETURN_INFO 
(
    RETURN_ID			INT 			IDENTITY	CONSTRAINT PK_RETURN_ID			PRIMARY KEY
    ,CUSTOMER_ORDER_ID	INT							CONSTRAINT NN_CUSTOMER_ID		 NOT NULL
	,CONSTRAINT FK_RETURN_CUSTOMER_ORDER_ID FOREIGN KEY (CUSTOMER_ORDER_ID) REFERENCES CUSTOMER_ORDER(ORDER_ID)
    ,RETURN_DATE		DATE						CONSTRAINT NN_RETURN_DATE		 NOT NULL
    ,ORDER_QUANTITY		INT							CONSTRAINT NN_ORDER_QUANTITY	 NOT NULL
    ,TOTAL_AMOUNT		MONEY						CONSTRAINT NN_TOTAL_ANOUNT		 NOT NULL
    ,RETURN_REASON		VARCHAR(255)				CONSTRAINT NN_RETURN_REASON		 NOT NULL
)
;

--Creating Reward Table

CREATE TABLE REWARD 
(
    REWARD_ID			 INT				IDENTITY	CONSTRAINT PK_REWARD_ID				PRIMARY KEY
    ,REWARD_NAME		 VARCHAR(50)					CONSTRAINT NN_REWARD_NAME			NOT NULL
    ,REWARD_TYPE		 VARCHAR(50)					CONSTRAINT NN_REWARD_TYPE			NOT NULL
    ,REWARD_VALUE		 MONEY							CONSTRAINT NN_REWARD_VALUE			NOT NULL
    ,REWARD_EXPIRY_DATE  DATE							CONSTRAINT NN_REWARD_EXPIRY_DATE	NOT NULL
    ,CUSTOMER_ID		 INT							CONSTRAINT NN_CUSTOMER_ID			NOT NULL
	,CONSTRAINT FK_REWARD_CUSTOMER_ID FOREIGN KEY (CUSTOMER_ID) REFERENCES CUSTOMER(CUSTOMER_ID)
)
;


--Step 3: Populating the tables

--Populating Address Info Table

SET IDENTITY_INSERT ADDRESS_INFO ON;

INSERT INTO ADDRESS_INFO (ADDRESS_ID,STREET_ADDRESS,CITY,STATE,ZIPCODE )
VALUES
	(1,'1950 S York St','Denver','Colorado','80210')
	,(2,'9836 Kinsman Alley','Boulder','Colorado','80328')
	,(3,'45 Dwight Junction','Denver','Colorado','80299')
	,(4,'3083 Northland Crossing','Colorado Springs','Colorado','80904')
	,(5,'66581 Ohio Trail','Aurora','Colorado','80045')
	,(6,'70 Victoria Way','Littleton','Colorado','80127')
	,(7,'26385 Esch Alley','Fort Collins','Colorado','80525')
	,(8,'8 Warbler Hill','Denver','Colorado','80204')
	,(9,'83 Lunder Park','Greeley','Colorado','80638')
	,(10,'80 Annamark Circle','Denver','Colorado','80204')
	,(11,'08704 Crest Line Center','Denver','Colorado','80241')
	,(12,'37 East Terrace','Denver','Colorado','80638')
	,(13,'116 Fallview Crossing','Aurora','Colorado','80204')
	,(14,'34677 Jackson Point','Denver','Colorado','80241')
	,(15,'7876 Eggendart Way','Aurora','Colorado','80015')
	,(16,'50402 Melody Drive','Fort Collins','Colorado','80525')
	,(17,'226 Mcguire Road','Denver','Colorado','80045')
	,(18,'36 Mallory Avenue','Colorado Springs','Colorado','80945')
	,(19,'28611 Springview Trail','Colorado Springs','Colorado','80910')
	,(20,'4 Holmberg Way','Grand Junction','Colorado','81505')
	,(21,'62771 Reinke Trail','Denver','Colorado','80270')
	,(22,'78136 Fallview Avenue','Colorado Springs','Colorado','80910')
	,(23,'3076 North Center','Arvada','Colorado','80005')
	,(24,'04 Maywood Point','Denver','Colorado','80228')
	,(25,'0 Amoth Junction','Littleton','Colorado','80160')
	,(26,'63525 Green Circle','Colorado Springs','Colorado','80951')
	,(27,'6 Commercial Junction','Denver','Colorado','80262')
	,(28,'1 Bultman Court','Denver','Colorado','80241')
	,(29,'7520 Montana Drive','Colorado Springs','Colorado','80925')
	,(30,'188 Oneill Court','Denver','Colorado','80241')
	,(31,'979 Kedzie Place','Boulder','Colorado','80328')
	,(32,'3 Hallows Circle','Colorado Springs','Colorado','80935')
	,(33,'965 Carberry Pass','Denver','Colorado','80299')
	,(34,'1 Sage Place','Greeley','Colorado','80127')
	,(35,'5168 Novick Place','Colorado Springs','Colorado','80628')
	,(36,'55991 Oak Valley Drive','Denver','Colorado','80951')
	,(37,'585 Fallview Pass','Grand Junction','Colorado','80255')
	,(38,'05 Acker Street','Colorado Springs','Colorado','81505')
	,(39,'5145 Eagle Crest Center','Fort Collins','Colorado','80935')
	,(40,'8729 Sloan Crossing','Denver','Colorado','80249')
	,(41,'918 Blaine Hill','Boulder','Colorado','80310')
	,(42,'2 Buena Vista Trail','Pueblo','Colorado','81010')
	,(43,'435 Clarendon Lane','Denver','Colorado','80217')
	,(44,'77 Sycamore Junction','Pueblo','Colorado','81010')
	,(45,'000 Moulton Street','Boulder','Colorado','80328')
	,(46,'8 Shoshone Point','Denver','Colorado','80255')
	,(47,'83346 Macpherson Park','Denver','Colorado','80228')
	,(48,'55 Bayside Park','Boulder','Colorado','80310')
	,(49,'65 Talisman Lane','Pueblo','Colorado','80044')
	,(50,'068 Bunker Hill Place','','Colorado','8')
	,(51,'681 Ronald Regan Road','','Colorado','8')
	,(52,'975 Pennsylvania Road','Aurora','Colorado','80045')
	,(53,'3965 Coleman Road','Denver','Colorado','80217')
	,(54,'02 Texas Street','Pueblo','Colorado','81015')
	,(55,'47612 Trailsway Circle','Denver','Colorado','80255')
	,(56,'58 Katie Plaza','Colorado Springs','Colorado','80920')
	,(57,'13657 Northridge Terrace','Arvada','Colorado','80005')
	,(58,'19 Lindbergh Avenue','Denver','Colorado','80217')
	,(59,'21 Havey Circle','Denver','Colorado','80228')
	,(60,'14 John Wall Trail','Denver','Colorado','80299')

;



--Populating Customer Table

SET IDENTITY_INSERT ADDRESS_INFO OFF;
SET IDENTITY_INSERT CUSTOMER ON;

INSERT INTO CUSTOMER( CUSTOMER_ID,CUSTOMER_NAME,CUSTOMER_ADDRESS_ID,CUSTOMER_PHONE,CUSTOMER_EMAIL )
VALUES
	(1,'John Smith',1,'720-413-6457','John.Smith@gmail.com')
   ,(2,'Martin.Luther',2, '123-456-7899', 'Martin.Luther@gmail.com')
   ,(3,'Alice Johnson',3, '123-456-7890', 'Alice.Johnson@gmail.com')
   ,(4,'Bob Williams',4, '555-123-4567', 'Bob.Williams@gmail.com')
   ,(5,'Eva Davis',5, '987-654-3210', 'Eva.Davis@gmail.com')
   ,(6,'Michael Brown',6, '111-222-3333', 'Michael.Brown@gmail.com')
   ,(7,'Sophia Miller',7, '444-555-6666', 'Sophia.Miller@gmail.com')
   ,(8,'Daniel Wilson',8, '777-888-9999', 'Daniel.Wilson@gmail.com')
   ,(9,'Olivia Moore',9, '321-987-6543', 'Olivia.Moore@gmail.com')
   ,(10,'William Taylor',10, '000-111-2222', 'William.Taylor@gmail.com')
	
;


--Populating Shipper Table

SET IDENTITY_INSERT CUSTOMER OFF;

SET IDENTITY_INSERT SHIPPER ON;


INSERT INTO SHIPPER (SHIPPER_ID,SHIPPER_NAME,SHIPPER_CITY,SHIPPER_PHONE,SHIPPER_EMAIL,SHIPPER_REGION ) --DECIDE IF WE WANT SERVICES TOO
VALUES
	(1,'FedEx','Denver','770-934-1234','denver_us@fedex.com','West')
	,(2,'GoGo Shipping Service','Littleton','550-436-2003','gogo@hotmail.com','SouthWest')
	,(3,'Quick & Easy Shipping Co.','Boulder','123-345-5678','qande@gmail.com','NorthEast')
	,(4,'ShipStation','Denver','332-123-8765','support@shipstation.com','West')
	,(5,'EasyShip Co.','Golden','113-445-3434','bussupport@easyship.com','NorthEast')
	,(6,'ShipPro','Littleton','656-770-9008','help@shippro.com','SouthWest')
	,(7,'Golden Express','Golden','776-234-1222','delivery@goldenexpress.com','NorthEast')
	,(8,'DHL','Boulder','345-005-1369','support@dhl.com','NorthEast')
	,(9,'Henry Logistics','Denver','665-003-6593','businessdelivery@henry.com','West')
	,(10,'Aurora Express','Aurora','554-007-3214','delivery@auroraexpress.com','East')
	,(11,'Sendle Shippers','Colorado Springs','467-000-1111','bus@sendleshippers.com','SouthEast')
;


--Populating Supplier Table

SET IDENTITY_INSERT SHIPPER OFF;

SET IDENTITY_INSERT SUPPLIER ON;

INSERT INTO SUPPLIER(SUPPLIER_ID,SUPPLIER_NAME,SUPPLIER_ADDRESS_ID,SUPPLIER_PHONE , SUPPLIER_EMAIL)
VALUES
    (1, 'ABC Electronics',11, '555-123-4567', 'info@abc-electronics.com')
    ,(2, 'XYZ Furniture',12, '777-987-6543', 'sales@xyz-furniture.com')
    ,(3, 'GHI Appliances',13, '111-222-3333', 'support@ghi-appliances.com')
    ,(4, 'LMN Clothing',14, '999-888-7777', 'orders@lmn-clothing.com')
    ,(5, 'PQR Supplies',15,'444-555-6666', 'info@pqr-supplies.com')
    ,(6, 'JKL Tech',16, '222-333-4444', 'contact@jkl-tech.com')
    ,(7, 'MNO Tools',17, '888-777-6666', 'info@mno-tools.com')
    ,(8, 'RST Instruments',18,'666-555-4444', 'support@rst-instruments.com')
    ,(9, 'UVW Gadgets',19, '333-444-5555', 'sales@uvw-gadgets.com')
    ,(10, 'EFG Supplies',20, '111-222-3333', 'orders@efg-supplies.com')
    ,(11, 'HIJ Electronics',21, '555-666-7777', 'info@hij-electronics.com')
    ,(12, 'KLM Furniture',22, '888-777-6666', 'sales@klm-furniture.com')
;


--Populating Product Table

SET IDENTITY_INSERT SUPPLIER OFF;

SET IDENTITY_INSERT PRODUCT ON;

INSERT INTO PRODUCT(PRODUCT_ID, PRODUCT_NAME, PRODUCT_PRICE, PRODUCT_CATEGORY, SUPPLIER_ID, PRODUCT_COST)
VALUES
    (101, 'T-Shirt', 10, 'Clothing', 1, 10.00)
    ,(102, 'Necklace', 20, 'Jewlery', 2, 20.00)
	,(103, 'Jeans', 30, 'Clothing', 3, 30.00)
	,(104, 'Khakis', 40, 'Clothing', 4, 40.00)
	,(105, 'Skirt', 50, 'Clothing', 5, 50.00)
	,(106, 'Purse', 60, 'Accesory', 6, 60.00)
	,(107, 'Sock', 70, 'Clothing', 7, 70.00)
	,(108, 'Coat', 80, 'Clothing', 8, 80.00)
	,(109, 'Underwear', 90, 'Clothing', 9, 90.00)
	,(110, 'Hat', 100, 'Accesory', 10, 100.00)
 ;   


--Populating Purchase order table


SET IDENTITY_INSERT PRODUCT OFF;

SET IDENTITY_INSERT PURCHASE_ORDER ON;

INSERT INTO PURCHASE_ORDER (ORDER_ID,ORDER_DATE,ORDER_QUANTITY,TOTAL_AMOUNT,ORDER_ADDRESS_ID,ORDER_PRODUCT_ID,RECEIVED_DATE)
VALUES
	(1,'2023-04-19', 60,500,23,101,'2023-04-26')
	,(2,'2023-01-09', 100,1500,24,103,'2023-01-16')
	,(3,'2023-03-10', 160,1000,25,102,'2023-03-14')
	,(4,'2023-05-14', 30,5500,26,104,'2023-05-20')
	,(5,'2023-07-21', 60,700,27,110,'2023-07-26')
	,(6,'2023-04-10', 80,900,28,109,'2023-04-17')
	,(7,'2023-08-01', 600,8000,28,108,'2023-04-26')
	,(8,'2023-08-14', 100,12000,29,106,'2023-08-18')
	,(9,'2023-01-11', 20,3000,30,107,'2023-01-14')
	,(10,'2023-03-25', 30,700,31,105,'2023-03-28')
;


--Populating Department Table

SET IDENTITY_INSERT PURCHASE_ORDER OFF;

SET IDENTITY_INSERT DEPARTMENT ON;

INSERT INTO DEPARTMENT (DEPARTMENT_ID,DEPARTMENT_NAME )
VALUES
	(1,'Finance')
	,(2,'Operations')
	,(3,'Sales')
	,(4,'Accounting')
	,(5,'IT')
	,(6,'Logistics')
	,(7,'Business Development')
	,(8,'Human Resources')
	,(9,'Quality Assurance')
	,(10,'Supply Chain Management')
	,(11,'Marketing')
	,(12,'Services')
	,(13,'Legal')
;



--Populating Job Profile Table


SET IDENTITY_INSERT DEPARTMENT OFF;
SET IDENTITY_INSERT JOB_PROFILE ON;


INSERT INTO JOB_PROFILE (JOB_ID,DEPARTMENT_ID,JOB_NAME,MIN_SALARY,MAX_SALARY )
VALUES
	(1,1,'Finance Manager',150000,300000)
	,(2,2,'Customer Service Representative',50000,70000)
	,(3,2,'Administrative Assistant',55000,75000)
	,(4,3,'Sales representative',80000,140000)
	,(5,2,'Business Analyst',80000,150000)
	,(6,4,'Accountant',65000,90000)
	,(7,8,'Human Resource Personnel', 57000,85000)
	,(8,11,'Marketing Specialist', 60000,100000)
	,(9,5,'Chief Technology Officer',230000,390000)
	,(10,11,'Chief Marketing Officer',150000,450000)
	,(11,1,'Financial Analyst',65000,90000)
	,(12,10,'Product Manager',120000,200000)
	,(13,13,'Recruiting Manager',110000,180000)
	,(14,12,'Senior Cost Accountant',150000,230000)
	,(15,1,'Senior Financial Analyst',200000,300000)

;

--Populating Employee Table

SET IDENTITY_INSERT JOB_PROFILE OFF;
SET IDENTITY_INSERT EMPLOYEE ON;



INSERT INTO EMPLOYEE (EMPLOYEE_ID, FIRST_NAME, LAST_NAME,JOB_ID, ADDRESS_ID, EMPLOYEE_EMAIL, PHONE_NUMBER)
VALUES
    (1, 'John', 'Doe', 1, 32, 'john.doe@email.com', '123-456-7890')
    ,(2, 'Jane', 'Smith', 2, 33, 'jane.smith@email.com', '987-654-3210')
	,(3, 'John', 'Johnson', 3, 34, 'john.johnson@email.com', '124-282-4844')
	,(4, 'Emma', 'Tompson', 4, 35, 'Emma.Tompson@email.com', '864-254-4424')
	,(5, 'Noah', 'Williams', 5,  36, 'noah.williams@email.com', '837-827-9283')
	,(6, 'Mia', 'Brown', 6, 37, 'mia.brown@email.com', '923-834-0294')
	,(7, 'James', 'Davis', 8, 38, 'james.davis@email.com', '734-933-6539')
	,(8, 'Harper', 'Garcia',10,  39, 'harper.garcia@email.com', '632-854-9264')
	,(9, 'Henry', 'Miller', 11, 40, 'henry.miller@email.com', '534-092-3498')
	,(10, 'Abby', 'Martinez', 12, 41, 'abby.martinez@email.com', '034-736-9582')
 ;  

--Populating Employee PII Table

SET IDENTITY_INSERT EMPLOYEE OFF;
SET IDENTITY_INSERT EMPLOYEEPII ON;

INSERT INTO EMPLOYEEPII(EMPLOYEE_NAME, EMPLOYEE_ID, DOB, SSN)
VALUES
    ('John Doe', 1, '1990-05-15', '123-45-6789')
    ,('Jane Smith', 2, '1985-08-22', '987-65-4321')
	,('John Johnson', 3, '1990-02-20', '124-28-4844')
	,('Emma Tompson', 4, '1982-10-10', '864-24-4424')
	,('Noah Williams', 5, '1986-01-01', '837-82-9283')
	,('Mia Brown', 6, '1991-12-15', '923-34-0294')
	,('James Davis', 7, '1979-06-29', '734-93-6539')
	,('Harper Garcia', 8, '1994-07-26', '632-84-9264')
	,('Henry Miller', 9, '1998-03-19', '534-92-3498')
	,('Abby Martinez', 10, '1974-05-25', '034-76-9582')
;


--Populating Customer Order Table

SET IDENTITY_INSERT EMPLOYEEPII OFF;
SET IDENTITY_INSERT CUSTOMER_ORDER ON;

INSERT INTO CUSTOMER_ORDER (ORDER_ID, CUSTOMER_ID, ORDER_DATE, ORDER_QUANTITY, TOTAL_AMOUNT, ORDER_ADDRESS_ID, ORDER_EMPLOYEE_ID, ORDER_SHIPPER_ID)
VALUES
	(1, 1, '2023-01-01', 5, 100.00, 42, 1, 1)
	,(2, 2, '2023-01-02', 3, 75.50, 43, 2, 1)
	,(3, 3, '2023-01-05', 2, 45.00, 44, 3, 2)
	,(4, 4, '2023-01-10', 4, 80.00, 45, 4, 2)
	,(5, 5, '2023-02-15', 1, 25.00, 46, 4, 2)
	,(6, 6, '2023-03-03', 3, 60.00, 47, 2, 3)
	,(7, 7, '2023-03-10', 2, 35.50, 48, 6, 4)
	,(8, 8, '2023-04-05', 4, 90.00, 49, 7, 5)
	,(9, 9, '2023-04-15', 2, 40.00, 50, 8, 7)
	,(10, 10, '2023-05-01', 3, 70.50, 51, 10, 9)
;

--Populating Return Info Table

SET IDENTITY_INSERT CUSTOMER_ORDER OFF;
SET IDENTITY_INSERT RETURN_INFO ON;

INSERT INTO RETURN_INFO (RETURN_ID, CUSTOMER_ORDER_ID, RETURN_DATE, ORDER_QUANTITY, TOTAL_AMOUNT, RETURN_REASON)
VALUES
	(1, 1, '2023-02-01', 2, 40.00, 'Defective product'),
	(2, 3, '2023-02-05', 1, 20.25, 'Wrong item shipped'),
	(3, 2, '2023-02-10', 3, 60.00, 'Changed mind'),
	(4, 4, '2023-02-15', 2, 30.50, 'Damaged during shipping'),
	(5, 5, '2023-03-01', 1, 15.00, 'Not as described'),
	(6, 6, '2023-03-05', 2, 35.00, 'Ordered by mistake'),
	(7, 7, '2023-03-10', 1, 20.50, 'Defective product'),
	(8, 8, '2023-03-15', 3, 55.00, 'Wrong item shipped'),
	(9, 9, '2023-04-01', 2, 30.00, 'Changed mind'),
	(10, 10, '2023-04-05', 1, 18.75, 'Damaged during shipping')
;


--Populating Reward Table

SET IDENTITY_INSERT RETURN_INFO OFF;
SET IDENTITY_INSERT REWARD ON;

INSERT INTO REWARD (REWARD_ID, REWARD_NAME, REWARD_TYPE, REWARD_VALUE, REWARD_EXPIRY_DATE, CUSTOMER_ID)
VALUES
	(1, 'Discount Coupon', 'Discount', 10.00, '2023-12-31', 1),
	(2, 'Gift Card', 'Gift', 25.00, '2024-06-30', 2),
	(3, 'Points Bonus', 'Points', 5.00, '2023-11-30', 3),
	(4, 'Discount Voucher', 'Discount', 15.00, '2024-03-31', 4),
	(5, 'Free Shipping', 'Shipping', 20.00, '2023-09-30',5),
	(6, 'Cashback', 'Cashback', 12.50, '2024-02-28', 6),
	(7, 'Bonus Points', 'Points', 8.00, '2023-10-31', 7),
	(8, 'Special Discount', 'Discount', 18.00, '2024-04-30', 8),
	(9, 'Gift Voucher', 'Gift', 30.00, '2023-05-31', 9),
	(10, 'Early Access', 'Access', 15.50, '2023-07-31', 10)
;



--Step 4: Showing table output



SELECT * FROM ADDRESS_INFO;

SELECT * FROM SHIPPER;

SELECT * FROM SUPPLIER;

SELECT * FROM CUSTOMER;

SELECT * FROM PRODUCT;

SELECT * FROM DEPARTMENT;

SELECT * FROM JOB_PROFILE;

SELECT * FROM  PURCHASE_ORDER;

SELECT * FROM  EMPLOYEE;

SELECT * FROM  EMPLOYEEPII;

SELECT * FROM CUSTOMER_ORDER;

SELECT * FROM RETURN_INFO;

SELECT * FROM REWARD;

----------

--Step 5: Views and Procedure

--View 1


CREATE VIEW dbo.CustomerOrderView AS

SELECT TOP 10
    CO.ORDER_ID,
    CO.ORDER_DATE,
    CO.ORDER_QUANTITY,
    CO.TOTAL_AMOUNT,
    C.CUSTOMER_NAME,
    A.STREET_ADDRESS,
    A.CITY,
    A.STATE,
    A.ZIPCODE,
    E.FIRST_NAME + ' ' + E.LAST_NAME AS EMPLOYEE_NAME,
    S.SHIPPER_NAME
FROM
    CUSTOMER_ORDER CO
LEFT JOIN CUSTOMER C 
	ON CO.CUSTOMER_ID = C.CUSTOMER_ID
LEFT JOIN ADDRESS_INFO A 
	ON CO.ORDER_ADDRESS_ID = A.ADDRESS_ID
LEFT JOIN EMPLOYEE E 
	ON CO.ORDER_EMPLOYEE_ID = E.EMPLOYEE_ID
LEFT JOIN SHIPPER S 
	ON CO.ORDER_SHIPPER_ID = S.SHIPPER_ID

ORDER BY
	CO.TOTAL_AMOUNT DESC
;

--Showing View 2 output:

SELECT * FROM CustomerOrderView;

--View 2:

CREATE VIEW dbo.ProductPurchaseView AS

SELECT 
    PO.ORDER_ID
    ,PO.ORDER_DATE
    ,PO.ORDER_QUANTITY
    ,PO.TOTAL_AMOUNT
    ,P.PRODUCT_NAME
    ,P.PRODUCT_PRICE
    ,P.PRODUCT_CATEGORY
    ,S.SUPPLIER_NAME
    
FROM PURCHASE_ORDER PO

LEFT JOIN PRODUCT P 
	ON PO.ORDER_PRODUCT_ID = P.PRODUCT_ID
LEFT JOIN SUPPLIER S 
	ON P.SUPPLIER_ID = S.SUPPLIER_ID

;

--Showing View 2 output:

SELECT * FROM ProductPurchaseView;


 --Procedure:

CREATE OR ALTER PROC dbo.sp_EmployeePayInfo  @EmployeeID INT AS 
	SET NOCOUNT ON; 

	IF @EmployeeID > 0 
		BEGIN 

		SELECT 
			E.FIRST_NAME+ ' '+ E.LAST_NAME AS EMP_NAME
			,J.JOB_NAME
			,J.MIN_SALARY
			,J.MAX_SALARY
			,PII.SSN
		
		FROM EMPLOYEE E
		
		INNER JOIN EMPLOYEEPII PII
			ON PII.EMPLOYEE_ID = E.EMPLOYEE_ID
		INNER JOIN JOB_PROFILE J
			ON J.JOB_ID=E.JOB_ID
		
		WHERE 1=1 
			AND E.EMPLOYEE_ID = @EmployeeID; --the Procedure is going to return the above selected outputs for the inputed EmployeeID
		
		RETURN 0; 
		END 
		
		ELSE 
		BEGIN 
			RETURN -1; 
		END; 
GO

-- Executing the procedure for Employee 1:

EXEC dbo.sp_EmployeePayInfo @EmployeeID = 1; 
GO




