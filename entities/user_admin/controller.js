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

module.exports.addNewItem = function(body, callback){
	db.query('INSERT INTO item VALUES (?, ?, ?, ?, ?, ?)',
		[body.itemCode, body.name, body.supplier, body.unitPrice, body.quantity, body.description], (err, rows) => {
			console.log('rows ', rows);
			if (err) callback(err);
			else callback(null, rows);
		}
	);
}

module.exports.updateItem = function(body, callback){
	db.query('UPDATE item SET name = ?, supplier = ?, unitPrice = ?, quantity = ?, description = ? WHERE itemCode = ?',
		[body.name, body.supplier, body.unitPrice, body.quantity, body.description, body.itemCode], (err, rows) => {
			console.log('rows ', rows);
			if (err) callback(err);
			else callback(null, rows);
		}
	);
}

module.exports.deleteItem = function(itemCode, callback){
	db.query('DELETE FROM item WHERE itemCode = ?',
		itemCode, (err, rows) => {
			console.log('rows ', rows);
			if (err) callback(err);
			else callback(null, rows);

		}
	);
}

module.exports.prNjoinItem = function(callback){

	db.query('SELECT requestID, userId, dateSubmitted, itemCode, quantity FROM pr NATURAL JOIN pr_item WHERE dateApproved IS NULL', (err, rows) => {
		if (err) callback(err);
		else callback(null, rows);
	}
	);
}

module.exports.poNjoinItem = function(callback){

	db.query('SELECT requestID, userId, dateSubmitted, itemCode, quantity FROM pr NATURAL JOIN pr_item WHERE dateApproved IS NOT NULL', (err, rows) => {
		if (err) callback(err);
		else callback(null, rows);
	}
	);
}

module.exports.approvePurchReq = function (requestID, userID, callback){
	var date = new Date();
	db.query('UPDATE pr SET dateApproved = ?, approvedBy = ? WHERE requestID = ?', 
		[date, userID, requestID], (err, rows) => {
			console.log('rows ', rows);
			if (err) callback(err);
			else callback(null, rows);		
			
		}
	);
}

module.exports.getItem = function (itemCode, callback){
	console.log(itemCode+"a");
	db.query('SELECT * FROM item WHERE itemCode = ?', itemCode, (err, rows) => {
			console.log('rows ', rows);
			if (err) callback(err);
			else callback(null, rows);		
			
		}
	);
		
}