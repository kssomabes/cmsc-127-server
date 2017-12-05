const db = require('../../database/connection');

module.exports.logIn = function(credentials, callback){
	db.query('SELECT * FROM user WHERE username = ? AND password = ?', [credentials.username, credentials.password], (err, rows)=>{
		if (err) callback(err);
		else callback(null, rows[0]);
	});
}