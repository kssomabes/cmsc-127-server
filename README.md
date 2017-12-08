<h1 align="center"></br> Purchase Requisition System </br>
	      <img src="https://img.shields.io/badge/status-development-yellow.svg" />
</h1>
</br>
<h4 align="center">A system for recording purchase requisitions, purchase orders, inventory and delivered materials in a company. </br></br> In partial fulfillment of the requirements for CMSC 127: File Processing and Database Systems</h4>

# Installation
1. Install [NodeJS](https://nodejs.org/en/download/) and [MySQL](https://dev.mysql.com/downloads/installer/).
2. Install latest version of [Yarn](https://yarnpkg.com/en/docs/install) or with `npm install yarn -g`.
3. Install dependencies with `yarn install`.
4. Load database schema `yarn run build`.

## Start
1. Start the server with `yarn start`.
2. Access the api through `http://localhost:3001/<route>`.

## Tables

### user
```shell
+-------------+------------------------+------+-----+---------+-------+
| Field       | Type                   | Null | Key | Default | Extra |
+-------------+------------------------+------+-----+---------+-------+
| userID      | int(5)                 | NO   | PRI | NULL    |       |
| username    | varchar(24)            | NO   |     | NULL    |       |
| password    | varchar(12)            | NO   |     | NULL    |       |
| name        | varchar(40)            | NO   |     | NULL    |       |
| department  | varchar(30)            | NO   |     | NULL    |       |
| position    | varchar(40)            | NO   |     | NULL    |       |
| accountType | enum('NORMAL','ADMIN') | NO   |     | NULL    |       |
+-------------+------------------------+------+-----+---------+-------+
```

### user_normal
```shell
+------------+-------------+------+-----+---------+-------+
| Field      | Type        | Null | Key | Default | Extra |
+------------+-------------+------+-----+---------+-------+
| userID     | int(5)      | NO   | PRI | NULL    |       |
| email      | varchar(30) | NO   |     | NULL    |       |
| noOfReq    | int(4)      | NO   |     | NULL    |       |
| contactNum | varchar(15) | YES  |     | NULL    |       |
+------------+-------------+------+-----+---------+-------+
```

### user_admin
```shell
+---------+--------+------+-----+---------+-------+
| Field   | Type   | Null | Key | Default | Extra |
+---------+--------+------+-----+---------+-------+
| adminID | int(5) | NO   |     | NULL    |       |
| userID  | int(5) | NO   | PRI | NULL    |       |
+---------+--------+------+-----+---------+-------+
```

### pr
```shell
+---------------+----------+------+-----+---------+----------------+
| Field         | Type     | Null | Key | Default | Extra          |
+---------------+----------+------+-----+---------+----------------+
| requestID     | int(5)   | NO   | PRI | NULL    | auto_increment |
| userID        | int(5)   | NO   | MUL | NULL    |                |
| dateSubmitted | datetime | NO   |     | NULL    |                |
| dateApproved  | datetime | YES  |     | NULL    |                |
| approvedBy    | int(5)   | YES  | MUL | NULL    |                |
+---------------+----------+------+-----+---------+----------------+
```

### item
```shell
+-------------+--------------+------+-----+---------+----------------+
| Field       | Type         | Null | Key | Default | Extra          |
+-------------+--------------+------+-----+---------+----------------+
| itemCode    | int(5)       | NO   | PRI | NULL    | auto_increment |
| name        | varchar(30)  | NO   |     | NULL    |                |
| supplier    | varchar(30)  | NO   |     | NULL    |                |
| unitPrice   | decimal(5,2) | NO   |     | NULL    |                |
| quantity    | int(4)       | NO   |     | NULL    |                |
| description | varchar(255) | YES  |     | NULL    |                |
+-------------+--------------+------+-----+---------+----------------+
```

### pr_item
```shell
+-----------+--------+------+-----+---------+-------+
| Field     | Type   | Null | Key | Default | Extra |
+-----------+--------+------+-----+---------+-------+
| requestID | int(5) | NO   | MUL | NULL    |       |
| itemCode  | int(5) | NO   | MUL | NULL    |       |
| quantity  | int(4) | NO   |     | NULL    |       |
+-----------+--------+------+-----+---------+-------+
```

### delivered_mat
```shell
+--------------+----------+------+-----+---------+-------+
| Field        | Type     | Null | Key | Default | Extra |
+--------------+----------+------+-----+---------+-------+
| requestID    | int(5)   | NO   | PRI | NULL    |       |
| userID       | int(5)   | YES  | MUL | NULL    |       |
| deliveryDate | datetime | YES  |     | NULL    |       |
+--------------+----------+------+-----+---------+-------+
```
