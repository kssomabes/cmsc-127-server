DROP USER IF EXISTS 'cmsc127'@'localhost';
CREATE USER 'cmsc127'@'localhost' IDENTIFIED BY 'cmsc127';

DROP DATABASE IF EXISTS purchreq;
CREATE DATABASE purchreq;

GRANT SUPER ON *.* TO 'cmsc127'@'localhost';
GRANT ALL PRIVILEGES ON purchreq.* TO 'cmsc127'@'localhost' WITH GRANT OPTION;

USE purchreq;

CREATE TABLE user(
	userID INT (5) NOT NULL PRIMARY KEY,
	username VARCHAR (24) NOT NULL,
	password VARCHAR (12) NOT NULL,
	name VARCHAR (40) NOT NULL,
	department VARCHAR (30) NOT NULL,
	position VARCHAR (40) NOT NULL,
	accountType ENUM ("NORMAL", "ADMIN") NOT NULL
);

CREATE TABLE user_normal(
	email VARCHAR (30) NOT NULL,
	noOfReq INT (4) NOT NULL,
	contactNum VARCHAR (15) DEFAULT NULL,
	userID INT (5) NOT NULL PRIMARY KEY,
	CONSTRAINT user_normal_user_fk FOREIGN KEY (userID) 
	REFERENCES user(userID)
);

CREATE TABLE user_admin(
	adminID INT (5) NOT NULL,
	userID INT (5) NOT NULL PRIMARY KEY,
	CONSTRAINT user_admin_user_fk FOREIGN KEY (userID) 
	REFERENCES user(userID)
);

CREATE TABLE pr(
	requestID INT (5) NOT NULL AUTO_INCREMENT PRIMARY KEY,
	userID INT (5) NOT NULL,
	dateSubmitted datetime NOT NULL,
	dateApproved datetime DEFAULT NULL,
	-- userRequester can be derived by getting the userID then getting the name
	approvedBy INT (5) DEFAULT NULL,
	-- adminID can be derived by getting the userID of user_admin then its adminID
	CONSTRAINT purchase_requisition_user_fk FOREIGN KEY (userID)
	REFERENCES user_normal(userID),
	CONSTRAINT purchase_requisition_user_admin_fk FOREIGN KEY (approvedBy)
	REFERENCES user_admin(userID) 
);

CREATE TABLE delivered_mat(
	requestID INT (5) NOT NULL PRIMARY KEY,
	userID INT (5) NOT NULL,
	deliveryDate datetime ,
	-- userRequester can be derived by getting the userID then getting the name
	CONSTRAINT delivered_mat_user_fk FOREIGN KEY (userID)
	REFERENCES user(userID),
	CONSTRAINT delivered_mat_pr_fk FOREIGN KEY (requestID)
	REFERENCES pr(requestID)
);

-- Item Inventory: users are only allowed to request the items that exist here

CREATE TABLE item(
	itemCode INT (5) NOT NULL PRIMARY KEY,
	name VARCHAR (30) NOT NULL, 
	supplier VARCHAR (30) NOT NULL,
	unitPrice DECIMAL(5,2) NOT NULL,
	quantity INT (4) NOT NULL,
	-- totalPrice is derived
	description VARCHAR(255) DEFAULT NULL
);

CREATE TABLE pr_item(
	requestID INT (5) NOT NULL,
	itemCode INT (5) NOT NULL,
	quantity INT (4) NOT NULL,
	CONSTRAINT pr_item_pr_fk FOREIGN KEY (requestID)
	REFERENCES pr(requestID),
		CONSTRAINT pr_item_purchase_requisition_fk FOREIGN KEY (itemCode)
	REFERENCES item(itemCode)
);



INSERT INTO user (`userID`, `username`, `password`, `name`, `department`, `position`, `accountType`) 
 VALUES (1, 'user', 'user', 'Some Name', 'HR', 'Employer', 'NORMAL');

INSERT INTO user (`userID`, `username`, `password`, `name`, `department`, `position`, `accountType`) 
 VALUES (2, 'admin', 'admin', 'Some Name', 'Finance', 'Accountant', 'ADMIN');

INSERT INTO user_admin (`adminID`, `userID`) VALUES (1, 2);
INSERT INTO user_normal (`email`, `noOfReq`, `contactNum`, `userID`) VALUES ('user@email.com', 12, '09222222', 1);

INSERT INTO item (`itemCode`, `name`, `supplier`, `unitPrice`, `quantity`, `description`) VALUES (1, 'Bond Paper', 'National Bookstore', 156.75, 2, 'Used for printing');
INSERT INTO item (`itemCode`, `name`, `supplier`, `unitPrice`, `quantity`, `description`) VALUES (2, 'Ballpoint Pen', 'National Bookstore', 32.50, 6, 'Used for writing');

INSERT INTO pr (`requestID`, `userID`, `dateSubmitted`, `dateApproved`, `approvedBy`) VALUES (1, 1, NOW(), NULL, NULL);
INSERT INTO pr_item (`requestID`, `itemCode`, `quantity`) VALUES(1, 1, 20);
INSERT INTO pr_item (`requestID`, `itemCode`, `quantity`) VALUES(1, 2, 50);

INSERT INTO pr (`requestID`, `userID`, `dateSubmitted`, `dateApproved`, `approvedBy`) VALUES (2, 1, NOW(), NOW(), 2);
INSERT INTO pr_item (`requestID`, `itemCode`, `quantity`) VALUES(2, 2, 10);