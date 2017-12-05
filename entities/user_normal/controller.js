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


module.exports.deletePurchReq = function(requestID, callback){
	//Checks first if purch req is not approved yet
	db.query('SELECT * FROM pr WHERE requestID = ? AND dateApproved IS NULL',
		requestID, (err, rows) => {
		console.log('rows ', rows);
		if (err) callback(err);
		else{
			db.query('DELETE FROM pr_item WHERE requestID = ?',
				requestID, (err, rows) => {
				console.log('rows ', rows);
				if (err) callback(err);
				else{
					db.query('DELETE FROM pr WHERE requestID = ?',
					requestID, (err, rows) => {
						console.log('rows ', rows);
						if (err) callback(err);
						else callback(null, rows);
					});
					callback(null, rows);
					}
				});
			callback(null, rows);
		}
	});
}


module.exports.updatePurchReq = function(body, callback){
	db.query('UPDATE pr_item SET itemCode = ?, quantity = ? WHERE requestID = ?',
		[body.itemCode, body.quantity, body.requestID], (err, rows) => {
			console.log('rows ', rows);
			if (err) callback(err);
			else callback(null, rows);
		}
	);
}

module.exports.addNewPurchReq = function(body, callback){
	const date = new Date();

	db.query('INSERT INTO pr VALUES (?, ?, ?, ?, ?)',
		[body.requestID, body.userID, date, 'NULL', 'NULL'], (err, rows) => {
		console.log('rows ', rows)
		if (err) callback(err);
		else callback(null, rows);
		}
	);
}

module.exports.addPurchItem = function(body, callback){
	db.query('INSERT INTO pr_item VALUES (?, ?, ?)',
		[body.requestID, body.itemCode, body.quantity], (err, rows) => {
		console.log('rows ', rows);
		if (err) callback(err);
		else callback(null, rows);
		}
	);
}