const db = require('../../database/connection');

module.exports.getAll = function(callback){

	db.query('SELECT * FROM user_admin', (err, rows) => {
		if (err) callback(err);
		else callback(null, rows);
	});
}

module.exports.getAllPurchReq = function (callback){

	db.query('SELECT * FROM pr WHERE dateApproved is NULL ORDER BY dateSubmitted', (err, rows) => {
		if (err) callback(err);
		else callback(null, rows);
	});

}

module.exports.getAllPurchOrder = function (callback){

	db.query('SELECT * FROM pr WHERE dateApproved is NOT NULL ORDER BY dateApproved DESC', (err, rows) => {
		if (err) callback(err);
		else callback(null, rows);
	});

}

module.exports.getAllPurchReqOfUser = function (userID, callback){
	
	db.query('SELECT * FROM pr WHERE userID = ? AND dateApproved IS NULL ORDER BY dateSubmitted', 
		userID, (err, rows) => {
			console.log('rows ', rows);
			if (err) callback(err);
			else callback(null, rows);		
			
		}
	);
		
}

module.exports.getAllPurchOrderOfUser = function (userID, callback){
	
	db.query('SELECT * FROM pr WHERE userID = ? AND dateApproved IS NOT NULL ORDER BY dateSubmitted', 
		userID, (err, rows) => {
			console.log('rows ', rows);
			if (err) callback(err);
			else callback(null, rows);		
			
		}
	);
		
}