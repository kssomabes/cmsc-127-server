const db = require('../../database/connection');

module.exports.getMyPurchReq = function(userID, callback){

	db.query('SELECT * FROM pr WHERE userID = ? AND dateApproved IS NULL', 
		userID, (err, rows) => {
			console.log('rows ', rows);
			if (err) callback(err);
			else callback(null, rows);		
			
		}
	);
}

module.exports.getMyPurchOrder = function(userID, callback){
	// Purchase Orders are the approved Purchase Requisitions 
	db.query('SELECT * FROM pr WHERE userID = ? AND dateApproved IS NOT NULL ORDER BY dateApproved DESC', 
		userID, (err, rows) => {
			console.log('rows ', rows);
			if (err) callback(err);
			else callback(null, rows);

		}
	);
}