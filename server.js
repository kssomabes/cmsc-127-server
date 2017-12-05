const express = require('express');
const app = express();
const bodyParser = require('body-parser');
const mysql = require('mysql');
const logger = require('morgan');
const connection = require('./database/connection');
const session = require('express-session');

const router = require('./router');

// CORS

app.use(function(req, res, next) {
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Credentials', 'true');
  res.setHeader('Access-Control-Allow-Methods', 'GET,HEAD,OPTIONS,POST,PUT,DELETE');
  res.setHeader('Access-Control-Allow-Headers', 'Access-Control-Allow-Headers, Origin,Accept, X-Requested-With, Content-Type, Access-Control-Request-Method, Access-Control-Request-Headers');

  res.setHeader('Cache-Control', 'no-cache');
  next();
});


//configure app to use bodyParser()
app.use(logger('dev'));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({extended: true}));


app.use(
  session({
    key: 'purchreq',
    secret: 'purchreq',
    resave: true,
    saveUninitialized: true,
    createDatabaseTable: true,
    checkExpirationInterval: 900000,
    expiration: 86400000
  })
);

app.use(router);


app.listen(3001, (err) => {
  if (err) { console.log(err); }
  else { console.log('\nServer is running at http://localhost:3001'); }
});


module.exports = app;