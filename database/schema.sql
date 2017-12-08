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
	userID INT (5) NOT NULL PRIMARY KEY,
	email VARCHAR (30) NOT NULL,
	noOfReq INT (4) NOT NULL,
	contactNum VARCHAR (15) DEFAULT NULL,
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
	userID INT (5) DEFAULT NULL,
	deliveryDate datetime ,
	-- userRequester can be derived by getting the userID then getting the name
	CONSTRAINT delivered_mat_user_fk FOREIGN KEY (userID)
	REFERENCES user(userID),
	CONSTRAINT delivered_mat_pr_fk FOREIGN KEY (requestID)
	REFERENCES pr(requestID)
);

-- Item Inventory: users are only allowed to request the items that exist here

CREATE TABLE item(
	itemCode INT (5) NOT NULL AUTO_INCREMENT PRIMARY KEY,
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

-- Database insertion for user --
INSERT INTO user (`userID`, `username`, `password`, `name`, `department`, `position`, `accountType`) VALUES (1, 'user', 'user', 'Some Name', 'HR', 'Employer', 'NORMAL');
INSERT INTO user (`userID`, `username`, `password`, `name`, `department`, `position`, `accountType`) VALUES (2, 'admin', 'admin', 'Some Name', 'Finance', 'Accountant', 'ADMIN');
INSERT INTO user (`userID`, `username`, `password`, `name`, `department`, `position`, `accountType`) VALUES (3, 'ekuhn', 'd3e4369635a1', 'Ed Simonis DDS', ' Accounting', ' Manager', 'ADMIN');
INSERT INTO user (`userID`, `username`, `password`, `name`, `department`, `position`, `accountType`) VALUES (4, 'hoppe.dillon', '8fa856151709', 'Veronica Hamill DVM', ' Sales', ' Manager', 'NORMAL');
INSERT INTO user (`userID`, `username`, `password`, `name`, `department`, `position`, `accountType`) VALUES (5, 'hansen.ruthe', 'c9b7f0593e61', 'Flossie Terry', 'HR', ' Staff', 'NORMAL');
INSERT INTO user (`userID`, `username`, `password`, `name`, `department`, `position`, `accountType`) VALUES (6, 'laurence26', '206c14933b8a', 'Jakayla Schultz', ' Finance', ' Clerk', 'ADMIN');
INSERT INTO user (`userID`, `username`, `password`, `name`, `department`, `position`, `accountType`) VALUES (7, 'shane', 'c6c88a54d134', 'Jarred Gislason', ' Finance', ' Employee', 'ADMIN');
INSERT INTO user (`userID`, `username`, `password`, `name`, `department`, `position`, `accountType`) VALUES (8, 'anna.grady', '5a9d37783f8b', 'Hope Wolff MD', ' IT', ' Employee', 'NORMAL');
INSERT INTO user (`userID`, `username`, `password`, `name`, `department`, `position`, `accountType`) VALUES (9, 'ursula.gusikowski', 'c7e7e21b0803', 'Talia Ritchie', ' IT', ' Receptionist', 'NORMAL');
INSERT INTO user (`userID`, `username`, `password`, `name`, `department`, `position`, `accountType`) VALUES (10, 'aron35', '8234695ef5b7', 'Gloria Kertzmann', ' Finance', ' Clerk', 'ADMIN');
INSERT INTO user (`userID`, `username`, `password`, `name`, `department`, `position`, `accountType`) VALUES (11, 'maggio.leanne', 'eefe86eb8ff8', 'Dr. Tania Rohan MD', ' Sales', ' Employee', 'ADMIN');
INSERT INTO user (`userID`, `username`, `password`, `name`, `department`, `position`, `accountType`) VALUES (12, 'jsanford', 'ef89fbefec7f', 'Prof. Obie Casper Jr.', ' Sales', ' Clerk', 'NORMAL');
INSERT INTO user (`userID`, `username`, `password`, `name`, `department`, `position`, `accountType`) VALUES (13, 'schulist.blanche', '8f7cef80a5f3', 'Mrs. Catharine Conn', ' Sales', ' Employee', 'ADMIN');
INSERT INTO user (`userID`, `username`, `password`, `name`, `department`, `position`, `accountType`) VALUES (14, 'becker.amelia', '47c1bac09adf', 'Lucienne Rohan', ' Marketing', ' Staff', 'NORMAL');
INSERT INTO user (`userID`, `username`, `password`, `name`, `department`, `position`, `accountType`) VALUES (15, 'dweber', '9116f10304d1', 'Orpha Jerde', ' Marketing', ' Receptionist', 'NORMAL');
INSERT INTO user (`userID`, `username`, `password`, `name`, `department`, `position`, `accountType`) VALUES (16, 'heller.maci', '0c8d4d223ff6', 'Jordon Torp', ' Finance', ' Employee', 'NORMAL');
INSERT INTO user (`userID`, `username`, `password`, `name`, `department`, `position`, `accountType`) VALUES (17, 'brett.kris', '23091e4df00e', 'Linwood Bartell IV', ' IT', ' Staff', 'NORMAL');
INSERT INTO user (`userID`, `username`, `password`, `name`, `department`, `position`, `accountType`) VALUES (18, 'king.rodrigo', 'db041ebdf851', 'Ike Beatty', ' Accounting', 'Accountant', 'NORMAL');
INSERT INTO user (`userID`, `username`, `password`, `name`, `department`, `position`, `accountType`) VALUES (19, 'kane51', '04a98925c8ba', 'Zita Harvey PhD', ' Marketing', ' Staff', 'NORMAL');
INSERT INTO user (`userID`, `username`, `password`, `name`, `department`, `position`, `accountType`) VALUES (20, 'maxime.price', 'ff45b410cf25', 'Elmore Rolfson', ' IT', ' Staff', 'NORMAL');
INSERT INTO user (`userID`, `username`, `password`, `name`, `department`, `position`, `accountType`) VALUES (21, 'hickle.avery', '3c3dd19380f1', 'Celestino Schneider', ' Finance', ' Manager', 'NORMAL');
INSERT INTO user (`userID`, `username`, `password`, `name`, `department`, `position`, `accountType`) VALUES (22, 'tillman.rosalyn', '67cd0a73bd55', 'Cloyd Koepp', ' Sales', ' Staff', 'NORMAL');
INSERT INTO user (`userID`, `username`, `password`, `name`, `department`, `position`, `accountType`) VALUES (23, 'hahn.ellen', '9332970fbd02', 'Henri Ziemann', 'HR', ' Staff', 'NORMAL');
INSERT INTO user (`userID`, `username`, `password`, `name`, `department`, `position`, `accountType`) VALUES (24, 'kautzer.muriel', 'd897265d1412', 'Prof. Eden Hartmann PhD', ' Sales', ' Employee', 'NORMAL');
INSERT INTO user (`userID`, `username`, `password`, `name`, `department`, `position`, `accountType`) VALUES (25, 'gusikowski.ronaldo', 'd771877764f4', 'Prof. Delilah Boyle DVM', 'HR', ' Employee', 'ADMIN');
INSERT INTO user (`userID`, `username`, `password`, `name`, `department`, `position`, `accountType`) VALUES (26, 'sister25', '5a1b4d4375e0', 'Prof. Jannie Kemmer', ' Marketing', ' Receptionist', 'NORMAL');
INSERT INTO user (`userID`, `username`, `password`, `name`, `department`, `position`, `accountType`) VALUES (27, 'althea.baumbach', '6e3e61b20998', 'Leonardo Hayes I', ' IT', ' Clerk', 'NORMAL');
INSERT INTO user (`userID`, `username`, `password`, `name`, `department`, `position`, `accountType`) VALUES (28, 'jesus51', '911492c8d67f', 'Dr. Euna Denesik', 'HR', ' Clerk', 'NORMAL');
INSERT INTO user (`userID`, `username`, `password`, `name`, `department`, `position`, `accountType`) VALUES (29, 'amelia58', '052c7652269c', 'Jackeline Medhurst', ' Accounting', 'Accountant', 'NORMAL');
INSERT INTO user (`userID`, `username`, `password`, `name`, `department`, `position`, `accountType`) VALUES (30, 'lydia.cole', '2b982dd57e71', 'Clint Beier', 'HR', ' Receptionist', 'NORMAL');
INSERT INTO user (`userID`, `username`, `password`, `name`, `department`, `position`, `accountType`) VALUES (31, 'celestino.kulas', '6ce1645e155e', 'Wava Boyer', 'HR', ' Staff', 'NORMAL');
INSERT INTO user (`userID`, `username`, `password`, `name`, `department`, `position`, `accountType`) VALUES (32, 'therese53', '46bf44cdd8e9', 'Christa Bergnaum IV', 'HR', ' Staff', 'NORMAL');
INSERT INTO user (`userID`, `username`, `password`, `name`, `department`, `position`, `accountType`) VALUES (33, 'merritt17', '526a659a5f5a', 'Sophia Cruickshank', ' Finance', ' Staff', 'NORMAL');
INSERT INTO user (`userID`, `username`, `password`, `name`, `department`, `position`, `accountType`) VALUES (34, 'ugrimes', '285ccac8a32b', 'Alfreda Von', 'HR', ' Employee', 'ADMIN');
INSERT INTO user (`userID`, `username`, `password`, `name`, `department`, `position`, `accountType`) VALUES (35, 'hansen.bud', 'ebdc0e39b0c2', 'Morris Johnson', ' Sales', ' Staff', 'NORMAL');
INSERT INTO user (`userID`, `username`, `password`, `name`, `department`, `position`, `accountType`) VALUES (36, 'jean49', '764620e4c444', 'Mrs. Dejah Renner', ' Sales', ' Receptionist', 'NORMAL');
INSERT INTO user (`userID`, `username`, `password`, `name`, `department`, `position`, `accountType`) VALUES (37, 'laron85', '35d6e84e0f34', 'Norbert Mitchell', ' Sales', ' Employee', 'NORMAL');
INSERT INTO user (`userID`, `username`, `password`, `name`, `department`, `position`, `accountType`) VALUES (38, 'bechtelar.rylee', '528dbd289aa4', 'Nathanial Lesch', ' IT', ' Receptionist', 'NORMAL');
INSERT INTO user (`userID`, `username`, `password`, `name`, `department`, `position`, `accountType`) VALUES (39, 'halvorson.antonina', '6bc00a9d8adc', 'Prof. Donavon Kessler', ' Sales', ' Employee', 'NORMAL');
INSERT INTO user (`userID`, `username`, `password`, `name`, `department`, `position`, `accountType`) VALUES (40, 'padberg.antonio', '53bedfca1ddd', 'Mr. Percy Stracke Jr.', ' Sales', ' Staff', 'NORMAL');
INSERT INTO user (`userID`, `username`, `password`, `name`, `department`, `position`, `accountType`) VALUES (41, 'jhills', '5ac6d5fb3d22', 'Dr. General Hand', ' Sales', ' Clerk', 'NORMAL');
INSERT INTO user (`userID`, `username`, `password`, `name`, `department`, `position`, `accountType`) VALUES (42, 'bernie.barrows', '67c56e756803', 'Sage Quitzon', ' Finance', 'Accountant', 'ADMIN');
INSERT INTO user (`userID`, `username`, `password`, `name`, `department`, `position`, `accountType`) VALUES (43, 'amber88', '2681c6f11c18', 'Juana White', ' Finance', ' Manager', 'ADMIN');
INSERT INTO user (`userID`, `username`, `password`, `name`, `department`, `position`, `accountType`) VALUES (44, 'iberge', 'e86ebd640a68', 'Rachel Hagenes', 'HR', ' Staff', 'NORMAL');
INSERT INTO user (`userID`, `username`, `password`, `name`, `department`, `position`, `accountType`) VALUES (45, 'tromp.kasey', 'f24c7453d97f', 'Wallace Kuhlman', ' Sales', ' Receptionist', 'ADMIN');
INSERT INTO user (`userID`, `username`, `password`, `name`, `department`, `position`, `accountType`) VALUES (46, 'hester.spencer', '9a43c394980f', 'Raina Herman', ' Accounting', ' Clerk', 'ADMIN');
INSERT INTO user (`userID`, `username`, `password`, `name`, `department`, `position`, `accountType`) VALUES (47, 'alisha48', '7eeeb4ad98a2', 'Tristin Ruecker', ' Sales', 'Accountant', 'ADMIN');
INSERT INTO user (`userID`, `username`, `password`, `name`, `department`, `position`, `accountType`) VALUES (48, 'magali.schaefer', 'f9b6fb912ed0', 'Keagan Kautzer', ' Finance', ' Receptionist', 'ADMIN');
INSERT INTO user (`userID`, `username`, `password`, `name`, `department`, `position`, `accountType`) VALUES (49, 'mante.myah', '0ff4e062cc78', 'Hermann Greenfelder MD', ' Finance', ' Manager', 'NORMAL');
INSERT INTO user (`userID`, `username`, `password`, `name`, `department`, `position`, `accountType`) VALUES (50, 'philip74', 'f1199ce901e0', 'Myra Heidenreich', ' Sales', ' Receptionist', 'ADMIN');
INSERT INTO user (`userID`, `username`, `password`, `name`, `department`, `position`, `accountType`) VALUES (51, 'pfannerstill.rosemary', '101f3390958b', 'Nicolas Streich', 'HR', ' Manager', 'NORMAL');
INSERT INTO user (`userID`, `username`, `password`, `name`, `department`, `position`, `accountType`) VALUES (52, 'ruby93', '1e199fffc206', 'Chadrick Lynch', ' Accounting', ' Receptionist', 'ADMIN');
INSERT INTO user (`userID`, `username`, `password`, `name`, `department`, `position`, `accountType`) VALUES (53, 'dakota.corkery', '5f63527f4f9c', 'Mrs. Alyce Zulauf Jr.', ' Sales', ' Receptionist', 'NORMAL');
INSERT INTO user (`userID`, `username`, `password`, `name`, `department`, `position`, `accountType`) VALUES (54, 'zgerhold', '5b6fa7c9dc56', 'Dr. Willis Hoppe', ' IT', ' Staff', 'ADMIN');
INSERT INTO user (`userID`, `username`, `password`, `name`, `department`, `position`, `accountType`) VALUES (55, 'fritsch.sydney', 'bca1d070b7c4', 'Reva McGlynn', ' Sales', 'Accountant', 'ADMIN');
INSERT INTO user (`userID`, `username`, `password`, `name`, `department`, `position`, `accountType`) VALUES (56, 'bode.andreane', 'e517ed6b9c40', 'Mr. Burley Nicolas', ' Accounting', ' Staff', 'ADMIN');
INSERT INTO user (`userID`, `username`, `password`, `name`, `department`, `position`, `accountType`) VALUES (57, 'breitenberg.hollis', 'ecdb6fe3530c', 'Elvie Hodkiewicz', ' Marketing', ' Clerk', 'ADMIN');
INSERT INTO user (`userID`, `username`, `password`, `name`, `department`, `position`, `accountType`) VALUES (58, 'broberts', '43b34647481a', 'Josh Mraz Sr.', ' Marketing', 'Accountant', 'ADMIN');
INSERT INTO user (`userID`, `username`, `password`, `name`, `department`, `position`, `accountType`) VALUES (59, 'smith.wilburn', '4d3f9355d89d', 'Dr. Jarod Huel MD', ' Marketing', ' Employee', 'ADMIN');
INSERT INTO user (`userID`, `username`, `password`, `name`, `department`, `position`, `accountType`) VALUES (60, 'tschowalter', '97354fb2035b', 'Mr. Baylee Raynor IV', ' Accounting', ' Manager', 'ADMIN');
INSERT INTO user (`userID`, `username`, `password`, `name`, `department`, `position`, `accountType`) VALUES (61, 'rorn', '82f6ad4b6a2a', 'Ms. Sarah Welch Jr.', ' Sales', ' Clerk', 'ADMIN');
INSERT INTO user (`userID`, `username`, `password`, `name`, `department`, `position`, `accountType`) VALUES (62, 'davis.berniece', '82a89b1b034a', 'Caterina Runte', 'HR', ' Employee', 'NORMAL');
INSERT INTO user (`userID`, `username`, `password`, `name`, `department`, `position`, `accountType`) VALUES (63, 'zlarkin', '9177fc4a159d', 'Dorthy Tromp', 'HR', ' Receptionist', 'ADMIN');
INSERT INTO user (`userID`, `username`, `password`, `name`, `department`, `position`, `accountType`) VALUES (64, 'ejacobson', 'ad77b4343d77', 'Prof. Armando Walter', 'HR', ' Staff', 'ADMIN');
INSERT INTO user (`userID`, `username`, `password`, `name`, `department`, `position`, `accountType`) VALUES (65, 'chaim37', '516f1c1a8e25', 'Angelina Smitham', 'HR', ' Receptionist', 'ADMIN');
INSERT INTO user (`userID`, `username`, `password`, `name`, `department`, `position`, `accountType`) VALUES (66, 'brisa77', 'a9aaa6ee7ea2', 'Estella Hermann', ' Marketing', ' Receptionist', 'ADMIN');
INSERT INTO user (`userID`, `username`, `password`, `name`, `department`, `position`, `accountType`) VALUES (67, 'kutch.erwin', '2bd5523bcd00', 'Desmond Farrell PhD', ' Accounting', ' Manager', 'ADMIN');
INSERT INTO user (`userID`, `username`, `password`, `name`, `department`, `position`, `accountType`) VALUES (68, 'mayer.jacey', '3ed65f2edf61', 'Rigoberto Boyer', ' Sales', ' Employee', 'ADMIN');
INSERT INTO user (`userID`, `username`, `password`, `name`, `department`, `position`, `accountType`) VALUES (69, 'mjast', '80ec53f1d5eb', 'Prof. Laury Macejkovic MD', ' Sales', ' Employee', 'NORMAL');
INSERT INTO user (`userID`, `username`, `password`, `name`, `department`, `position`, `accountType`) VALUES (70, 'eadams', '844fdcdc4c29', 'Korey Koelpin', 'HR', 'Accountant', 'ADMIN');
INSERT INTO user (`userID`, `username`, `password`, `name`, `department`, `position`, `accountType`) VALUES (71, 'zhilpert', 'bbcd5d1b2b25', 'Heaven Koss', ' Accounting', ' Employee', 'NORMAL');
INSERT INTO user (`userID`, `username`, `password`, `name`, `department`, `position`, `accountType`) VALUES (72, 'uriel22', '3cdccb31d0ca', 'Rachelle Purdy II', 'HR', ' Clerk', 'NORMAL');
INSERT INTO user (`userID`, `username`, `password`, `name`, `department`, `position`, `accountType`) VALUES (73, 'howe.aileen', '3e2b259a6972', 'Dr. Kevin Swaniawski II', ' Accounting', ' Clerk', 'ADMIN');
INSERT INTO user (`userID`, `username`, `password`, `name`, `department`, `position`, `accountType`) VALUES (74, 'lavada.kassulke', '5787edba89c9', 'Dr. Eleazar Maggio', ' Accounting', ' Receptionist', 'NORMAL');
INSERT INTO user (`userID`, `username`, `password`, `name`, `department`, `position`, `accountType`) VALUES (75, 'dee.walker', 'a5ffe789f6cd', 'Prof. D\'angelo Prohaska I', ' Sales', ' Clerk', 'ADMIN');
INSERT INTO user (`userID`, `username`, `password`, `name`, `department`, `position`, `accountType`) VALUES (76, 'asa.block', 'bed472312146', 'Prof. Minnie Langworth II', ' Sales', 'Accountant', 'ADMIN');
INSERT INTO user (`userID`, `username`, `password`, `name`, `department`, `position`, `accountType`) VALUES (77, 'ricky.rath', 'b74fa06100bb', 'Nathanael Conn', ' IT', ' Employee', 'NORMAL');
INSERT INTO user (`userID`, `username`, `password`, `name`, `department`, `position`, `accountType`) VALUES (78, 'mertz.pamela', 'b8073cb77d0b', 'Herta Hamill', ' Accounting', ' Manager', 'NORMAL');
INSERT INTO user (`userID`, `username`, `password`, `name`, `department`, `position`, `accountType`) VALUES (79, 'kraig47', '5d41b35def0b', 'Brianne Schultz', ' Finance', ' Clerk', 'ADMIN');
INSERT INTO user (`userID`, `username`, `password`, `name`, `department`, `position`, `accountType`) VALUES (80, 'murray.estrella', '8e2f3ab8cefe', 'Kolby Botsford', ' Finance', ' Clerk', 'ADMIN');
INSERT INTO user (`userID`, `username`, `password`, `name`, `department`, `position`, `accountType`) VALUES (81, 'price.roxane', 'f40d57f6962e', 'Carolyne Mraz', ' Marketing', ' Receptionist', 'ADMIN');
INSERT INTO user (`userID`, `username`, `password`, `name`, `department`, `position`, `accountType`) VALUES (82, 'susan.treutel', '4835823ec707', 'Kiara Osinski', ' Accounting', ' Clerk', 'ADMIN');
INSERT INTO user (`userID`, `username`, `password`, `name`, `department`, `position`, `accountType`) VALUES (83, 'knikolaus', '3a76c181de54', 'Elise Schultz', ' Marketing', ' Staff', 'NORMAL');
INSERT INTO user (`userID`, `username`, `password`, `name`, `department`, `position`, `accountType`) VALUES (84, 'tabitha.eichmann', 'be3e2eee5e3b', 'Ms. Rhoda McDermott', ' IT', ' Employee', 'NORMAL');
INSERT INTO user (`userID`, `username`, `password`, `name`, `department`, `position`, `accountType`) VALUES (85, 'rollin.marquardt', 'eb2ceadb204e', 'Stuart O\'Reilly', 'HR', ' Clerk', 'ADMIN');
INSERT INTO user (`userID`, `username`, `password`, `name`, `department`, `position`, `accountType`) VALUES (86, 'darrin.flatley', '902b65c5ebc4', 'Glenda Schoen', ' IT', 'Accountant', 'ADMIN');
INSERT INTO user (`userID`, `username`, `password`, `name`, `department`, `position`, `accountType`) VALUES (87, 'alphonso55', '79ca19ad0342', 'Wava Weimann', ' Accounting', ' Staff', 'ADMIN');
INSERT INTO user (`userID`, `username`, `password`, `name`, `department`, `position`, `accountType`) VALUES (88, 'jakubowski.emery', 'd0ec0d0e5750', 'Mr. Manley Wilkinson', ' IT', ' Staff', 'NORMAL');
INSERT INTO user (`userID`, `username`, `password`, `name`, `department`, `position`, `accountType`) VALUES (89, 'stehr.berniece', '8f4c0517b1e7', 'Lucas Cruickshank', 'HR', ' Receptionist', 'ADMIN');
INSERT INTO user (`userID`, `username`, `password`, `name`, `department`, `position`, `accountType`) VALUES (90, 'medhurst.kiera', 'dfa7bdd6f393', 'Glen Gerlach', 'HR', ' Clerk', 'ADMIN');
INSERT INTO user (`userID`, `username`, `password`, `name`, `department`, `position`, `accountType`) VALUES (91, 'cleveland63', 'a8fdd25b2f59', 'Braden Waters', ' Accounting', 'Accountant', 'ADMIN');
INSERT INTO user (`userID`, `username`, `password`, `name`, `department`, `position`, `accountType`) VALUES (92, 'hfadel', '31483da76b6b', 'Cullen Friesen', ' Accounting', ' Employee', 'ADMIN');
INSERT INTO user (`userID`, `username`, `password`, `name`, `department`, `position`, `accountType`) VALUES (93, 'michale10', '5eafa461d980', 'Arnulfo Cormier', ' Marketing', ' Employee', 'ADMIN');
INSERT INTO user (`userID`, `username`, `password`, `name`, `department`, `position`, `accountType`) VALUES (94, 'shany.bashirian', '605392bd7497', 'Mr. Darrell Kirlin IV', ' Finance', ' Staff', 'ADMIN');
INSERT INTO user (`userID`, `username`, `password`, `name`, `department`, `position`, `accountType`) VALUES (95, 'pharvey', '0e398e378e6b', 'Miss Makenzie Lowe Jr.', ' Sales', ' Clerk', 'NORMAL');
INSERT INTO user (`userID`, `username`, `password`, `name`, `department`, `position`, `accountType`) VALUES (96, 'cremin.bell', 'a528317be3f1', 'Ed Goodwin Jr.', ' Marketing', ' Manager', 'ADMIN');
INSERT INTO user (`userID`, `username`, `password`, `name`, `department`, `position`, `accountType`) VALUES (97, 'gheaney', '636696f25893', 'Herta Wiegand', ' Marketing', ' Employee', 'NORMAL');
INSERT INTO user (`userID`, `username`, `password`, `name`, `department`, `position`, `accountType`) VALUES (98, 'aida00', 'a7e1166a7991', 'Mr. Donavon O\'Hara Jr.', ' Accounting', ' Manager', 'NORMAL');
INSERT INTO user (`userID`, `username`, `password`, `name`, `department`, `position`, `accountType`) VALUES (99, 'katlynn.gerlach', 'eaa15e6ce750', 'Deshawn Rosenbaum Sr.', ' Finance', ' Staff', 'ADMIN');
INSERT INTO user (`userID`, `username`, `password`, `name`, `department`, `position`, `accountType`) VALUES (100, 'kari.crooks', 'edf4010ef7c1', 'Kamron Kessler III', ' Accounting', ' Clerk', 'NORMAL');

-- Database insertion for user_admin --
INSERT INTO user_admin (`adminID`, `userID`) VALUES (1, 2);
INSERT INTO user_admin (`adminID`, `userID`) VALUES (2, 3);
INSERT INTO user_admin (`adminID`, `userID`) VALUES (3, 6);
INSERT INTO user_admin (`adminID`, `userID`) VALUES (4, 7);
INSERT INTO user_admin (`adminID`, `userID`) VALUES (5, 10);
INSERT INTO user_admin (`adminID`, `userID`) VALUES (6, 11);
INSERT INTO user_admin (`adminID`, `userID`) VALUES (7, 13);
INSERT INTO user_admin (`adminID`, `userID`) VALUES (8, 25);
INSERT INTO user_admin (`adminID`, `userID`) VALUES (9, 34);
INSERT INTO user_admin (`adminID`, `userID`) VALUES (10, 42);
INSERT INTO user_admin (`adminID`, `userID`) VALUES (11, 43);
INSERT INTO user_admin (`adminID`, `userID`) VALUES (12, 45);
INSERT INTO user_admin (`adminID`, `userID`) VALUES (13, 46);
INSERT INTO user_admin (`adminID`, `userID`) VALUES (14, 47);
INSERT INTO user_admin (`adminID`, `userID`) VALUES (15, 48);
INSERT INTO user_admin (`adminID`, `userID`) VALUES (16, 50);
INSERT INTO user_admin (`adminID`, `userID`) VALUES (17, 52);
INSERT INTO user_admin (`adminID`, `userID`) VALUES (18, 54);
INSERT INTO user_admin (`adminID`, `userID`) VALUES (19, 55);
INSERT INTO user_admin (`adminID`, `userID`) VALUES (20, 56);
INSERT INTO user_admin (`adminID`, `userID`) VALUES (21, 57);
INSERT INTO user_admin (`adminID`, `userID`) VALUES (22, 58);
INSERT INTO user_admin (`adminID`, `userID`) VALUES (23, 59);
INSERT INTO user_admin (`adminID`, `userID`) VALUES (24, 60);
INSERT INTO user_admin (`adminID`, `userID`) VALUES (25, 61);
INSERT INTO user_admin (`adminID`, `userID`) VALUES (26, 63);
INSERT INTO user_admin (`adminID`, `userID`) VALUES (27, 64);
INSERT INTO user_admin (`adminID`, `userID`) VALUES (28, 65);
INSERT INTO user_admin (`adminID`, `userID`) VALUES (29, 66);
INSERT INTO user_admin (`adminID`, `userID`) VALUES (30, 67);
INSERT INTO user_admin (`adminID`, `userID`) VALUES (31, 68);
INSERT INTO user_admin (`adminID`, `userID`) VALUES (32, 70);
INSERT INTO user_admin (`adminID`, `userID`) VALUES (33, 73);
INSERT INTO user_admin (`adminID`, `userID`) VALUES (34, 75);
INSERT INTO user_admin (`adminID`, `userID`) VALUES (35, 76);
INSERT INTO user_admin (`adminID`, `userID`) VALUES (36, 79);
INSERT INTO user_admin (`adminID`, `userID`) VALUES (37, 80);
INSERT INTO user_admin (`adminID`, `userID`) VALUES (38, 81);
INSERT INTO user_admin (`adminID`, `userID`) VALUES (39, 82);
INSERT INTO user_admin (`adminID`, `userID`) VALUES (40, 85);
INSERT INTO user_admin (`adminID`, `userID`) VALUES (41, 86);
INSERT INTO user_admin (`adminID`, `userID`) VALUES (42, 87);
INSERT INTO user_admin (`adminID`, `userID`) VALUES (43, 89);
INSERT INTO user_admin (`adminID`, `userID`) VALUES (44, 90);
INSERT INTO user_admin (`adminID`, `userID`) VALUES (45, 91);
INSERT INTO user_admin (`adminID`, `userID`) VALUES (46, 92);
INSERT INTO user_admin (`adminID`, `userID`) VALUES (47, 93);
INSERT INTO user_admin (`adminID`, `userID`) VALUES (48, 94);
INSERT INTO user_admin (`adminID`, `userID`) VALUES (49, 96);
INSERT INTO user_admin (`adminID`, `userID`) VALUES (50, 99);

-- Database insertion for user_normal --
INSERT INTO user_normal VALUES (1, 'user@email.com', 12, '09222222');
INSERT INTO user_normal VALUES (4, 'jamey.mohr@example.net', 0, '511-431-5209x23');
INSERT INTO user_normal VALUES (5, 'crist.ethan@example.net', 1, '+06(9)744618470');
INSERT INTO user_normal VALUES (8, 'orion75@example.net', 0, '(051)032-9291x2');
INSERT INTO user_normal VALUES (9, 'delpha.hand@example.net', 0, '814.460.6116x01');
INSERT INTO user_normal VALUES (12, 'luz.miller@example.com', 3, '+76(5)576489622');
INSERT INTO user_normal VALUES (14, 'tremblay.okey@example.net', 1, '798.290.6278');
INSERT INTO user_normal VALUES (15, 'karen.grimes@example.org', 0, '404.058.0144');
INSERT INTO user_normal VALUES (16, 'danial08@example.com', 2, '(920)414-7843x3');
INSERT INTO user_normal VALUES (17, 'anabelle.beer@example.net', 0, '1-498-557-6137x');
INSERT INTO user_normal VALUES (18, 'lou56@example.org', 2, '+66(3)900546219');
INSERT INTO user_normal VALUES (19, 'hortense.lockman@example.org', 0, '902.370.1423x72');
INSERT INTO user_normal VALUES (20, 'ines81@example.com', 1, '781-795-7253x27');
INSERT INTO user_normal VALUES (21, 'shannon.marks@example.net', 0, '078.136.2419');
INSERT INTO user_normal VALUES (22, 'dorothy52@example.org', 1, '067.668.7138');
INSERT INTO user_normal VALUES (23, 'cleora20@example.net', 0, '(019)859-7312x9');
INSERT INTO user_normal VALUES (24, 'tremaine90@example.net', 2, '644.266.4367');
INSERT INTO user_normal VALUES (26, 'justen.senger@example.net', 0, '842-229-7248x13');
INSERT INTO user_normal VALUES (27, 'szemlak@example.com', 0, '699-916-5034x75');
INSERT INTO user_normal VALUES (28, 'bayer.harold@example.com', 0, '361.450.7841');
INSERT INTO user_normal VALUES (29, 'linnie.pfannerstill@example.co', 0, '01497629609');
INSERT INTO user_normal VALUES (30, 'sshanahan@example.net', 0, '114.630.4185');
INSERT INTO user_normal VALUES (31, 'bethel97@example.net', 1, '00334360412');
INSERT INTO user_normal VALUES (32, 'dayana92@example.org', 0, '945-027-9266x10');
INSERT INTO user_normal VALUES (33, 'erdman.fannie@example.com', 0, '01051638579');
INSERT INTO user_normal VALUES (35, 'ritchie.orpha@example.org', 2, '+57(6)200185993');
INSERT INTO user_normal VALUES (36, 'brielle72@example.com', 0, '296.162.1823x29');
INSERT INTO user_normal VALUES (37, 'lori57@example.net', 2, '1-666-492-5063x');
INSERT INTO user_normal VALUES (38, 'ypaucek@example.net', 0, '782.510.8543');
INSERT INTO user_normal VALUES (39, 'nabbott@example.com', 2, '945-569-9870');
INSERT INTO user_normal VALUES (40, 'miller.jerel@example.org', 0, '1-222-823-0740x');
INSERT INTO user_normal VALUES (41, 'skylar35@example.com', 1, '(203)980-4948x2');
INSERT INTO user_normal VALUES (44, 'hilpert.ford@example.net', 0, '797.579.5253');
INSERT INTO user_normal VALUES (49, 'jlockman@example.org', 1, '04901300122');
INSERT INTO user_normal VALUES (51, 'gottlieb.merle@example.net', 1, '(284)226-6729x7');
INSERT INTO user_normal VALUES (53, 'flo.crist@example.org', 2, '370.356.7488x35');
INSERT INTO user_normal VALUES (62, 'peter.streich@example.net', 3, '748-532-3783');
INSERT INTO user_normal VALUES (69, 'maud.schowalter@example.org', 3, '03579987521');
INSERT INTO user_normal VALUES (71, 'eve86@example.com', 0, '+10(4)763536235');
INSERT INTO user_normal VALUES (72, 'luettgen.dennis@example.org', 0, '+99(3)160870473');
INSERT INTO user_normal VALUES (74, 'handerson@example.org', 0, '(158)824-2671x6');
INSERT INTO user_normal VALUES (77, 'ludwig.kautzer@example.com', 0, '1-689-651-8125');
INSERT INTO user_normal VALUES (78, 'talon.halvorson@example.org', 2, '591-598-6159');
INSERT INTO user_normal VALUES (83, 'mtowne@example.net', 0, '+55(6)946921744');
INSERT INTO user_normal VALUES (84, 'jacklyn94@example.net', 0, '(296)546-7940');
INSERT INTO user_normal VALUES (88, 'kunze.isabelle@example.org', 2, '727.281.3374');
INSERT INTO user_normal VALUES (95, 'charley.kreiger@example.net', 1, '651.913.0998x99');
INSERT INTO user_normal VALUES (97, 'smitham.georgianna@example.org', 0, '1-887-293-0698x');
INSERT INTO user_normal VALUES (98, 'aleen.wyman@example.net', 0, '(432)207-9665');
INSERT INTO user_normal VALUES (100, 'chansen@example.net', 2, '658.154.0380x37');

-- Database insertion for item --
INSERT INTO item (`itemCode`, `name`, `supplier`, `unitPrice`, `quantity`, `description`) VALUES (1, 'Bond Paper', 'National Bookstore', 156.75, 2, 'Used for printing');
INSERT INTO item (`itemCode`, `name`, `supplier`, `unitPrice`, `quantity`, `description`) VALUES (2, 'Ballpoint Pen', 'National Bookstore', 32.50, 6, 'Used for writing');
INSERT INTO item (`itemCode`, `name`, `supplier`, `unitPrice`, `quantity`, `description`) VALUES (3, 'Permanent Marker', 'Becker PLC', '10.47', 0, 'Dolores isi dolorem aut.');
INSERT INTO item (`itemCode`, `name`, `supplier`, `unitPrice`, `quantity`, `description`) VALUES (4, 'Whiteboard Marker', 'Kilback, Hegmann and Krajcik', '29.99', 6, 'Odit sint velit deleniti.');
INSERT INTO item (`itemCode`, `name`, `supplier`, `unitPrice`, `quantity`, `description`) VALUES (5, 'Eraser', 'Turner, Langworth and Stracke', '79.99', 7, 'Repellendus illum qui maiores.');
INSERT INTO item (`itemCode`, `name`, `supplier`, `unitPrice`, `quantity`, `description`) VALUES (6, 'Toner', 'Hagenes Inc', '1.12', 9, 'Quaerat doloribus occaecati et.');
INSERT INTO item (`itemCode`, `name`, `supplier`, `unitPrice`, `quantity`, `description`) VALUES (7, 'Ink', 'Huel-Cassin', '123.5', 7, 'Cupiditate utem et.');
INSERT INTO item (`itemCode`, `name`, `supplier`, `unitPrice`, `quantity`, `description`) VALUES (8, 'Staple Wire', 'Wiza Ltd', '12.50', 6, 'Qui et rerum nihil alias nobis.');
INSERT INTO item (`itemCode`, `name`, `supplier`, `unitPrice`, `quantity`, `description`) VALUES (9, 'Stapler', 'Kilback, Batz and Johnston', '519.50', 5, 'Qui omnis at velit at nihil.');
INSERT INTO item (`itemCode`, `name`, `supplier`, `unitPrice`, `quantity`, `description`) VALUES (10, 'Pencil', 'Rosenbaum PLC', '45.70', 9, 'Reprehenderit deleniti.');
INSERT INTO item (`itemCode`, `name`, `supplier`, `unitPrice`, `quantity`, `description`) VALUES (11, 'Sharpener', 'Labadie, Windler and Huel', '79.10', 8, 'Quo quasi quia est quia.');
INSERT INTO item (`itemCode`, `name`, `supplier`, `unitPrice`, `quantity`, `description`) VALUES (12, 'Notepad', 'Jenkins, Upton and Klein', '43.10', 3, 'Dolore est facere.');
INSERT INTO item (`itemCode`, `name`, `supplier`, `unitPrice`, `quantity`, `description`) VALUES (13, 'Notebook', 'West Ltd', '0.37', 1, 'Facere quia nihil ipsam.');
INSERT INTO item (`itemCode`, `name`, `supplier`, `unitPrice`, `quantity`, `description`) VALUES (14, 'Battery', 'Lindgren PLC', '824.37', 5, 'Laudantium corrupti.');
INSERT INTO item (`itemCode`, `name`, `supplier`, `unitPrice`, `quantity`, `description`) VALUES (15, 'Correction Fluid', 'Steuber-Donnelly', '576.00', 7, 'Ratione ullam est non fugit ut a.');
INSERT INTO item (`itemCode`, `name`, `supplier`, `unitPrice`, `quantity`, `description`) VALUES (16, 'Correction Tape', 'Rodriguez-Larson', '0.15', 8, 'Eligendi id facilis nostrum.');
INSERT INTO item (`itemCode`, `name`, `supplier`, `unitPrice`, `quantity`, `description`) VALUES (17, 'Duct Tape', 'Kautzer, Weissnat and Will', '12.50', 9, 'Et qui quia a.');
INSERT INTO item (`itemCode`, `name`, `supplier`, `unitPrice`, `quantity`, `description`) VALUES (18, 'Scotch Tape', 'Rippin-Erdman', '2.99', 2, 'Enim est minus suscipit.');
INSERT INTO item (`itemCode`, `name`, `supplier`, `unitPrice`, `quantity`, `description`) VALUES (19, 'Packaging Tape', 'Balistreri PLC', '45.99', 0, 'Dolores et saepe libero.');
INSERT INTO item (`itemCode`, `name`, `supplier`, `unitPrice`, `quantity`, `description`) VALUES (20, 'Masking Tape', 'Murazik LLC', '1.09', 1, 'Excepturi iste molestias dicta vel.');
INSERT INTO item (`itemCode`, `name`, `supplier`, `unitPrice`, `quantity`, `description`) VALUES (21, 'Glue', 'Ondricka, Stokes and Daugherty', '75.99', 2, 'Quo quas autem nihil in.');
INSERT INTO item (`itemCode`, `name`, `supplier`, `unitPrice`, `quantity`, `description`) VALUES (22, 'Scissors', 'Kunde, Nienow and Hayes', '12.99', 3, 'Sit qui modi occaecati aut.');
INSERT INTO item (`itemCode`, `name`, `supplier`, `unitPrice`, `quantity`, `description`) VALUES (23, 'Photopaper', 'Lemke-Smitham', '30.99', 2, 'Quidem ex aut harum.');
INSERT INTO item (`itemCode`, `name`, `supplier`, `unitPrice`, `quantity`, `description`) VALUES (24, 'Ruler', 'Schmeler, Emmerich and Rippin', '4.99', 2, 'Architecto fuga vitae voluptas.');
INSERT INTO item (`itemCode`, `name`, `supplier`, `unitPrice`, `quantity`, `description`) VALUES (25, 'Measuring Tape', 'Konopelski-Larson', '7.99', 5, 'Blanditiis sit accusamus aut.');
INSERT INTO item (`itemCode`, `name`, `supplier`, `unitPrice`, `quantity`, `description`) VALUES (26, 'Paper Clip', 'Frami LLC', '2.31', 4, 'Quis id ducimus et ');
INSERT INTO item (`itemCode`, `name`, `supplier`, `unitPrice`, `quantity`, `description`) VALUES (27, 'Binder', 'Hahn Inc', '349.98', 7, 'Aliquam quis ducimus et.');
INSERT INTO item (`itemCode`, `name`, `supplier`, `unitPrice`, `quantity`, `description`) VALUES (28, 'Folder', 'Christiansen, Krajcik and Orn', '41.99', 5, 'Dolore dolores illum.');
INSERT INTO item (`itemCode`, `name`, `supplier`, `unitPrice`, `quantity`, `description`) VALUES (29, 'Sliding Folder', 'Borer LLC', '78.99', 3, 'Mollitia odit maiores.');
INSERT INTO item (`itemCode`, `name`, `supplier`, `unitPrice`, `quantity`, `description`) VALUES (30, 'Short Envelope', 'Beahan-Schmeler', '807.83', 3, 'Iusto error ducimus.');
INSERT INTO item (`itemCode`, `name`, `supplier`, `unitPrice`, `quantity`, `description`) VALUES (31, 'Long Envelope', 'Bergnaum, Mraz and Towne', '12.50', 8, 'Mollitia quae dicta est.');
INSERT INTO item (`itemCode`, `name`, `supplier`, `unitPrice`, `quantity`, `description`) VALUES (32, 'Plastic Envelope', 'Mills-King', '0.48', 9, 'Omnis magni minus accusantium.');
INSERT INTO item (`itemCode`, `name`, `supplier`, `unitPrice`, `quantity`, `description`) VALUES (33, 'Illustration Board', 'Farrell-Turner', '57.99', 7, 'Modi dolores et facilis et.');
INSERT INTO item (`itemCode`, `name`, `supplier`, `unitPrice`, `quantity`, `description`) VALUES (34, 'Calculator', 'Kuvalis Group', '12.99', 0, 'Temporibus quidem aut ');
INSERT INTO item (`itemCode`, `name`, `supplier`, `unitPrice`, `quantity`, `description`) VALUES (35, 'ID Holder', 'Armstrong-Jacobson', '1.95', 6, 'Dolorem aut corporis dolor iste.');
INSERT INTO item (`itemCode`, `name`, `supplier`, `unitPrice`, `quantity`, `description`) VALUES (36, 'Highlighter', 'Balistreri, Zboncak and Wilkin', '79.99', 4, 'Fugit odio est.');
INSERT INTO item (`itemCode`, `name`, `supplier`, `unitPrice`, `quantity`, `description`) VALUES (37, 'Binder Clip', 'Hudson, Mueller and Howell', '2.93', 0, 'Mollitia quo explicabo odit.');
INSERT INTO item (`itemCode`, `name`, `supplier`, `unitPrice`, `quantity`, `description`) VALUES (38, 'ID Lace', 'Wolff-Turner', '12.50', 3, 'Ut incidunt et.');
INSERT INTO item (`itemCode`, `name`, `supplier`, `unitPrice`, `quantity`, `description`) VALUES (39, 'Tape Dispenser', 'Corwin Group', '15.99', 6, 'Eos totam magnam.');
INSERT INTO item (`itemCode`, `name`, `supplier`, `unitPrice`, `quantity`, `description`) VALUES (40, 'Glue Gun', 'Johnston Group', '75.99', 0, 'Quisquam sed reprehenderit.');
INSERT INTO item (`itemCode`, `name`, `supplier`, `unitPrice`, `quantity`, `description`) VALUES (41, 'Glue Sticks', 'Goldner, Rolfson and Kuhic', '0.90', 9, 'Molestias vitae.');
INSERT INTO item (`itemCode`, `name`, `supplier`, `unitPrice`, `quantity`, `description`) VALUES (42, 'Puncher', 'Donnelly-Haley', '10.99', 1, 'Quis accusamus cum.');
INSERT INTO item (`itemCode`, `name`, `supplier`, `unitPrice`, `quantity`, `description`) VALUES (43, 'Rubberbands', 'Schultz-Feest', '78.89', 5, 'Qui sit dicta autem natus sit.');
INSERT INTO item (`itemCode`, `name`, `supplier`, `unitPrice`, `quantity`, `description`) VALUES (44, 'Stamps', 'Franecki-Cormier', '14.25', 0, 'Molestias veritatis.');
INSERT INTO item (`itemCode`, `name`, `supplier`, `unitPrice`, `quantity`, `description`) VALUES (45, 'Ring Binders', 'Terry Group', '12.50', 0, 'Provident eligendi.');
INSERT INTO item (`itemCode`, `name`, `supplier`, `unitPrice`, `quantity`, `description`) VALUES (46, 'Whiteboard', 'Treutel LLC', '75.12', 5, 'Ea et omni non.');
INSERT INTO item (`itemCode`, `name`, `supplier`, `unitPrice`, `quantity`, `description`) VALUES (47, 'Printer', 'Gottlieb PLC', '940.99', 3, 'Quas quia cum quas nihil nihil.');
INSERT INTO item (`itemCode`, `name`, `supplier`, `unitPrice`, `quantity`, `description`) VALUES (48, 'Toilet Paper', 'Baumbach Inc', '14.01', 9, 'Voluptas dolor.');
INSERT INTO item (`itemCode`, `name`, `supplier`, `unitPrice`, `quantity`, `description`) VALUES (49, 'Paper Shredder', 'Cole, Satterfield and Wisozk', '71.99', 5, 'Et iusto commodi et.');
INSERT INTO item (`itemCode`, `name`, `supplier`, `unitPrice`, `quantity`, `description`) VALUES (50, 'Carbon Paper', 'Windler Group', '0.00', 5, 'Adipisci id odit omatus.');

-- Database insertion for purchase requisitions --
INSERT INTO pr (`requestID`, `userID`, `dateSubmitted`, `dateApproved`, `approvedBy`) VALUES (1, 1, NOW(), NULL, NULL);
INSERT INTO pr_item (`requestID`, `itemCode`, `quantity`) VALUES(1, 1, 20);
INSERT INTO pr_item (`requestID`, `itemCode`, `quantity`) VALUES(1, 2, 50);

INSERT INTO pr (`requestID`, `userID`, `dateSubmitted`, `dateApproved`, `approvedBy`) VALUES (3, 1, NOW(), NULL, NULL);
INSERT INTO pr_item (`requestID`, `itemCode`, `quantity`) VALUES(3, 12, 10);

INSERT INTO pr (`requestID`, `userID`, `dateSubmitted`, `dateApproved`, `approvedBy`) VALUES (4, 1, '2017-03-16 08:48:39', NULL, NULL);
INSERT INTO pr_item (`requestID`, `itemCode`, `quantity`) VALUES(4, 37, 45);

INSERT INTO pr (`requestID`, `userID`, `dateSubmitted`, `dateApproved`, `approvedBy`) VALUES (5, 1, '2017-07-16 10:48:39', NULL, NULL);
INSERT INTO pr_item (`requestID`, `itemCode`, `quantity`) VALUES(5, 10, 7);

INSERT INTO pr (`requestID`, `userID`, `dateSubmitted`, `dateApproved`, `approvedBy`) VALUES (6, 1, '2017-01-16 07:48:39', NULL, NULL);
INSERT INTO pr_item (`requestID`, `itemCode`, `quantity`) VALUES(6, 1, 2);
INSERT INTO pr_item (`requestID`, `itemCode`, `quantity`) VALUES(6, 2, 3);
INSERT INTO pr_item (`requestID`, `itemCode`, `quantity`) VALUES(6, 3, 15);

INSERT INTO pr (`requestID`, `userID`, `dateSubmitted`, `dateApproved`, `approvedBy`) VALUES (7, 1, '2017-10-16 02:48:39', NULL, NULL);
INSERT INTO pr_item (`requestID`, `itemCode`, `quantity`) VALUES(7, 5, 20);	

INSERT INTO pr (`requestID`, `userID`, `dateSubmitted`, `dateApproved`, `approvedBy`) VALUES (13, 5, NOW(), NULL, NULL);
INSERT INTO pr_item (`requestID`, `itemCode`, `quantity`) VALUES(13, 19, 3);

INSERT INTO pr (`requestID`, `userID`, `dateSubmitted`, `dateApproved`, `approvedBy`) VALUES (14, 12, NOW(), NULL, NULL);
INSERT INTO pr_item (`requestID`, `itemCode`, `quantity`) VALUES(14, 24, 7);
INSERT INTO pr_item (`requestID`, `itemCode`, `quantity`) VALUES(14, 23, 1);
INSERT INTO pr_item (`requestID`, `itemCode`, `quantity`) VALUES(14, 8, 5);

INSERT INTO pr (`requestID`, `userID`, `dateSubmitted`, `dateApproved`, `approvedBy`) VALUES (15, 14, NOW(), NULL, NULL);
INSERT INTO pr_item (`requestID`, `itemCode`, `quantity`) VALUES(15, 16, 9);

INSERT INTO pr (`requestID`, `userID`, `dateSubmitted`, `dateApproved`, `approvedBy`) VALUES (16, 16, NOW(), NULL, NULL);
INSERT INTO pr_item (`requestID`, `itemCode`, `quantity`) VALUES(16, 3, 2);
INSERT INTO pr_item (`requestID`, `itemCode`, `quantity`) VALUES(16, 35, 8);

INSERT INTO pr (`requestID`, `userID`, `dateSubmitted`, `dateApproved`, `approvedBy`) VALUES (23, 41, '2017-08-16 10:48:39', NULL, NULL);
INSERT INTO pr_item (`requestID`, `itemCode`, `quantity`) VALUES(23, 30, 5);

INSERT INTO pr (`requestID`, `userID`, `dateSubmitted`, `dateApproved`, `approvedBy`) VALUES (24, 49, '2017-08-16 09:48:39', NULL, NULL);
INSERT INTO pr_item (`requestID`, `itemCode`, `quantity`) VALUES(24, 38, 9);

INSERT INTO pr (`requestID`, `userID`, `dateSubmitted`, `dateApproved`, `approvedBy`) VALUES (25, 51, '2017-04-16 07:48:39', NULL, NULL);
INSERT INTO pr_item (`requestID`, `itemCode`, `quantity`) VALUES(25, 49, 1);

INSERT INTO pr (`requestID`, `userID`, `dateSubmitted`, `dateApproved`, `approvedBy`) VALUES (31, 95, '2017-07-16 08:48:39', NULL, NULL);
INSERT INTO pr_item (`requestID`, `itemCode`, `quantity`) VALUES(31, 18, 1);

INSERT INTO pr (`requestID`, `userID`, `dateSubmitted`, `dateApproved`, `approvedBy`) VALUES (32, 100, '2017-02-16 06:48:39', NULL, NULL);
INSERT INTO pr_item (`requestID`, `itemCode`, `quantity`) VALUES(32, 15, 3);

INSERT INTO pr (`requestID`, `userID`, `dateSubmitted`, `dateApproved`, `approvedBy`) VALUES (42, 1, NOW(), NULL, NULL);
INSERT INTO pr_item (`requestID`, `itemCode`, `quantity`) VALUES(42, 16, 4);

INSERT INTO pr (`requestID`, `userID`, `dateSubmitted`, `dateApproved`, `approvedBy`) VALUES (43, 100, NOW(), NULL, NULL);
INSERT INTO pr_item (`requestID`, `itemCode`, `quantity`) VALUES(43, 3, 2);
INSERT INTO pr_item (`requestID`, `itemCode`, `quantity`) VALUES(43, 5, 7);

INSERT INTO pr (`requestID`, `userID`, `dateSubmitted`, `dateApproved`, `approvedBy`) VALUES (44, 12, '2017-02-20 01:48:39', NULL, NULL);
INSERT INTO pr_item (`requestID`, `itemCode`, `quantity`) VALUES(44, 38, 1);

INSERT INTO pr (`requestID`, `userID`, `dateSubmitted`, `dateApproved`, `approvedBy`) VALUES (45, 1, '2017-04-10 07:48:39', NULL, NULL);
INSERT INTO pr_item (`requestID`, `itemCode`, `quantity`) VALUES(45, 42, 7);

INSERT INTO pr (`requestID`, `userID`, `dateSubmitted`, `dateApproved`, `approvedBy`) VALUES (46, 16, '2017-03-19 03:48:39', NULL, NULL);
INSERT INTO pr_item (`requestID`, `itemCode`, `quantity`) VALUES(46, 1, 20);
INSERT INTO pr_item (`requestID`, `itemCode`, `quantity`) VALUES(46, 7, 4);

INSERT INTO pr (`requestID`, `userID`, `dateSubmitted`, `dateApproved`, `approvedBy`) VALUES (47, 12, '2017-05-17 08:54:39', NULL, NULL);
INSERT INTO pr_item (`requestID`, `itemCode`, `quantity`) VALUES(47, 30, 5);

INSERT INTO pr (`requestID`, `userID`, `dateSubmitted`, `dateApproved`, `approvedBy`) VALUES (48, 1, '2017-03-05 08:48:56', NULL, NULL);
INSERT INTO pr_item (`requestID`, `itemCode`, `quantity`) VALUES(48, 26, 5);

INSERT INTO pr (`requestID`, `userID`, `dateSubmitted`, `dateApproved`, `approvedBy`) VALUES (49, 95, NOW(), NULL, NULL);
INSERT INTO pr_item (`requestID`, `itemCode`, `quantity`) VALUES(49, 3, 20);
INSERT INTO pr_item (`requestID`, `itemCode`, `quantity`) VALUES(49, 46, 1);

INSERT INTO pr (`requestID`, `userID`, `dateSubmitted`, `dateApproved`, `approvedBy`) VALUES (50, 12, NOW(), NULL, NULL);
INSERT INTO pr_item (`requestID`, `itemCode`, `quantity`) VALUES(50, 29, 50);

-- Database insertion for purchase orders --
INSERT INTO pr (`requestID`, `userID`, `dateSubmitted`, `dateApproved`, `approvedBy`) VALUES (2, 1, NOW(), NOW(), 2);
INSERT INTO pr_item (`requestID`, `itemCode`, `quantity`) VALUES(2, 2, 10);

INSERT INTO pr (`requestID`, `userID`, `dateSubmitted`, `dateApproved`, `approvedBy`) VALUES (8, 1, '2017-03-16 08:48:39', NOW(), 7);
INSERT INTO pr_item (`requestID`, `itemCode`, `quantity`) VALUES(8, 20, 5);

INSERT INTO pr (`requestID`, `userID`, `dateSubmitted`, `dateApproved`, `approvedBy`) VALUES (9, 1, '2013-03-16 09:48:39', '2015-03-16 10:48:39', 2);
INSERT INTO pr_item (`requestID`, `itemCode`, `quantity`) VALUES(9, 36, 3);

INSERT INTO pr (`requestID`, `userID`, `dateSubmitted`, `dateApproved`, `approvedBy`) VALUES (10, 1, '2012-03-16 09:48:39', '2014-03-16 11:48:39', 25);
INSERT INTO pr_item (`requestID`, `itemCode`, `quantity`) VALUES(10, 47, 1);

INSERT INTO pr (`requestID`, `userID`, `dateSubmitted`, `dateApproved`, `approvedBy`) VALUES (11, 1, '2016-03-16 09:48:39', NOW(), 25);
INSERT INTO pr_item (`requestID`, `itemCode`, `quantity`) VALUES(11, 48, 15);

INSERT INTO pr (`requestID`, `userID`, `dateSubmitted`, `dateApproved`, `approvedBy`) VALUES (12, 1, '2015-03-16 01:48:39', '2017-03-16 09:48:39', 2);
INSERT INTO pr_item (`requestID`, `itemCode`, `quantity`) VALUES(12, 34, 1);

INSERT INTO pr (`requestID`, `userID`, `dateSubmitted`, `dateApproved`, `approvedBy`) VALUES (17, 18, '2016-10-16 01:48:39', NOW(), 2);
INSERT INTO pr_item (`requestID`, `itemCode`, `quantity`) VALUES(17, 21, 1);
INSERT INTO pr_item (`requestID`, `itemCode`, `quantity`) VALUES(17, 33, 3);

INSERT INTO pr (`requestID`, `userID`, `dateSubmitted`, `dateApproved`, `approvedBy`) VALUES (18, 20, '2015-12-16 01:48:39', '2015-12-16 05:48:39', 3);
INSERT INTO pr_item (`requestID`, `itemCode`, `quantity`) VALUES(18, 17, 2);

INSERT INTO pr (`requestID`, `userID`, `dateSubmitted`, `dateApproved`, `approvedBy`) VALUES (19, 22, '2017-11-21 01:48:39', NOW(), 3);
INSERT INTO pr_item (`requestID`, `itemCode`, `quantity`) VALUES(19, 10, 7);

INSERT INTO pr (`requestID`, `userID`, `dateSubmitted`, `dateApproved`, `approvedBy`) VALUES (20, 24, '2017-11-16 05:48:39', NOW(), 7);
INSERT INTO pr_item (`requestID`, `itemCode`, `quantity`) VALUES(20, 36, 1);
INSERT INTO pr_item (`requestID`, `itemCode`, `quantity`) VALUES(20, 26, 5);

INSERT INTO pr (`requestID`, `userID`, `dateSubmitted`, `dateApproved`, `approvedBy`) VALUES (21, 31, NOW(), NOW(), 2);
INSERT INTO pr_item (`requestID`, `itemCode`, `quantity`) VALUES(21, 10, 7);

INSERT INTO pr (`requestID`, `userID`, `dateSubmitted`, `dateApproved`, `approvedBy`) VALUES (22, 35, '2017-08-16 09:48:39', NOW(), 2);
INSERT INTO pr_item (`requestID`, `itemCode`, `quantity`) VALUES(22, 12, 3);
INSERT INTO pr_item (`requestID`, `itemCode`, `quantity`) VALUES(22, 13, 7);

INSERT INTO pr (`requestID`, `userID`, `dateSubmitted`, `dateApproved`, `approvedBy`) VALUES (26, 53, '2016-12-16 01:48:39', '2016-12-16 05:48:39', 50);
INSERT INTO pr_item (`requestID`, `itemCode`, `quantity`) VALUES(26, 1, 3);
INSERT INTO pr_item (`requestID`, `itemCode`, `quantity`) VALUES(26, 22, 2);

INSERT INTO pr (`requestID`, `userID`, `dateSubmitted`, `dateApproved`, `approvedBy`) VALUES (27, 62, '2016-12-16 01:48:39', '2016-12-16 05:48:39', 50);
INSERT INTO pr_item (`requestID`, `itemCode`, `quantity`) VALUES(27, 40, 1);
INSERT INTO pr_item (`requestID`, `itemCode`, `quantity`) VALUES(27, 41, 7);
INSERT INTO pr_item (`requestID`, `itemCode`, `quantity`) VALUES(27, 44, 5);

INSERT INTO pr (`requestID`, `userID`, `dateSubmitted`, `dateApproved`, `approvedBy`) VALUES (28, 69, '2016-12-16 01:48:39', '2016-12-16 05:48:39', 50);
INSERT INTO pr_item (`requestID`, `itemCode`, `quantity`) VALUES(28, 50, 20);
INSERT INTO pr_item (`requestID`, `itemCode`, `quantity`) VALUES(28, 27, 3);
INSERT INTO pr_item (`requestID`, `itemCode`, `quantity`) VALUES(28, 7, 8);

INSERT INTO pr (`requestID`, `userID`, `dateSubmitted`, `dateApproved`, `approvedBy`) VALUES (29, 78, '2016-04-16 01:48:39', '2016-04-16 05:48:39', 7);
INSERT INTO pr_item (`requestID`, `itemCode`, `quantity`) VALUES(29, 6, 10);
INSERT INTO pr_item (`requestID`, `itemCode`, `quantity`) VALUES(29, 20, 12);

INSERT INTO pr (`requestID`, `userID`, `dateSubmitted`, `dateApproved`, `approvedBy`) VALUES (30, 88, '2016-07-16 01:48:39', '2016-07-16 05:48:39', 6);
INSERT INTO pr_item (`requestID`, `itemCode`, `quantity`) VALUES(30, 46, 3);
INSERT INTO pr_item (`requestID`, `itemCode`, `quantity`) VALUES(30, 36, 7);

INSERT INTO pr (`requestID`, `userID`, `dateSubmitted`, `dateApproved`, `approvedBy`) VALUES (33, 31, NOW(), NOW(), 3);
INSERT INTO pr_item (`requestID`, `itemCode`, `quantity`) VALUES(33, 50, 2);

INSERT INTO pr (`requestID`, `userID`, `dateSubmitted`, `dateApproved`, `approvedBy`) VALUES (34, 22, '2016-07-16 01:48:39', '2016-07-16 05:57:39', 2);
INSERT INTO pr_item (`requestID`, `itemCode`, `quantity`) VALUES(34, 10, 7);

INSERT INTO pr (`requestID`, `userID`, `dateSubmitted`, `dateApproved`, `approvedBy`) VALUES (35, 35, '2016-07-16 01:45:39', '2016-07-16 05:32:39', 2);
INSERT INTO pr_item (`requestID`, `itemCode`, `quantity`) VALUES(35, 41, 2);

INSERT INTO pr (`requestID`, `userID`, `dateSubmitted`, `dateApproved`, `approvedBy`) VALUES (36, 1, '2016-07-16 01:10:39', '2016-07-16 05:12:39', 2);
INSERT INTO pr_item (`requestID`, `itemCode`, `quantity`) VALUES(36, 10, 7);

INSERT INTO pr (`requestID`, `userID`, `dateSubmitted`, `dateApproved`, `approvedBy`) VALUES (37, 20, NOW(), NOW(), 3);
INSERT INTO pr_item (`requestID`, `itemCode`, `quantity`) VALUES(37, 10, 2);

INSERT INTO pr (`requestID`, `userID`, `dateSubmitted`, `dateApproved`, `approvedBy`) VALUES (38, 1, NOW(), NOW(), 3);
INSERT INTO pr_item (`requestID`, `itemCode`, `quantity`) VALUES(38, 7, 7);

INSERT INTO pr (`requestID`, `userID`, `dateSubmitted`, `dateApproved`, `approvedBy`) VALUES (39, 1, NOW(), NOW(), 2);
INSERT INTO pr_item (`requestID`, `itemCode`, `quantity`) VALUES(39, 41, 2);

INSERT INTO pr (`requestID`, `userID`, `dateSubmitted`, `dateApproved`, `approvedBy`) VALUES (40, 22, NOW(), NOW(), 2);
INSERT INTO pr_item (`requestID`, `itemCode`, `quantity`) VALUES(40, 8, 7);

INSERT INTO pr (`requestID`, `userID`, `dateSubmitted`, `dateApproved`, `approvedBy`) VALUES (41, 1, NOW(), NOW(), 3);
INSERT INTO pr_item (`requestID`, `itemCode`, `quantity`) VALUES(41, 13, 2);

-- Database insertion for delivered_mat --
INSERT INTO delivered_mat VALUES (9, NULL, '2015-03-16 10:48:39');
INSERT INTO delivered_mat VALUES (10, NULL, '2014-03-27 11:48:39');
INSERT INTO delivered_mat VALUES (11, NULL, NOW());
INSERT INTO delivered_mat VALUES (12, NULL, NOW());
INSERT INTO delivered_mat VALUES (34, 22, '2016-07-17 05:57:39');
INSERT INTO delivered_mat VALUES (35, 35, '2016-07-18 05:57:39');
INSERT INTO delivered_mat VALUES (36, 1, '2016-07-21 05:57:39');
INSERT INTO delivered_mat VALUES (40, 22, NOW());
INSERT INTO delivered_mat VALUES (41, 1, NOW());