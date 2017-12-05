const mysql = require('mysql');

const connection = mysql.createConnection({
  host: 'localhost',
  user: 'cmsc127',
  password: 'cmsc127',
  database: 'purchreq'
});

connection.connect(function(err) {
  if (!err) {
    console.log('Database is connected');
  } else {
  	console.log(err);
    console.log('Error while connecting with database');
  }
});

module.exports = connection;