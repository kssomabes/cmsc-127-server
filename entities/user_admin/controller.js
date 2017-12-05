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
	db.query('DELETE FROM pr_item WHERE requestID = ?',
		requestID, (err, rows) => {
			console.log('rows ', rows);
			if (err) callback(err);
			else callback(null, rows);

		}
	);

	db.query('DELETE FROM pr WHERE requestID = ?',
		requestID, (err, rows) => {
			console.log('rows ', rows);
			if (err) callback(err);
			else callback(null, rows);

		}
	);
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

module.exports.deleteItem= function(itemCode, callback){
	db.query('DELETE FROM item WHERE itemCode = ?',
		itemCode, (err, rows) => {
			console.log('rows ', rows);
			if (err) callback(err);
			else callback(null, rows);

		}
	);
}

module.exports.prNjoinPurchReq = function(callback){

	db.query('SELECT requestID, userId, dateSubmitted, itemCode, quantity, name, supplier, unitPrice, description FROM pr NATURAL JOIN pr_item NATURAL JOIN item WHERE dateApproved IS NULL', (err, rows) => {
		if (err) callback(err);
		else callback(null, rows);
	}
	);
}

module.exports.prNjoinPurchOrd = function(callback){

	db.query('SELECT requestID, userId, dateSubmitted, itemCode, quantity, name, supplier, unitPrice, description FROM pr NATURAL JOIN pr_item NATURAL JOIN item WHERE dateApproved IS NOT NULL', (err, rows) => {
		if (err) callback(err);
		else callback(null, rows);
	}
	);
}