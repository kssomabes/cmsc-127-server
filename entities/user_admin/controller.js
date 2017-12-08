const db = require('../../database/connection');

module.exports.getAll = function(callback){

	db.query('SELECT * FROM user_admin', (err, rows) => {
		if (err) callback(err);
		else callback(null, rows);
	});
}


module.exports.getAllPurchReq = function (callback){

	db.query('SELECT requestID, userID, dateSubmitted FROM pr WHERE dateApproved is NULL GROUP BY requestID ORDER BY dateSubmitted', (err, rows) => {
		console.log(err);
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
		else if (rows[0]===undefined) {
			console.log("No rows found");
			callback(rows);
		}
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
				}
			});
		}
	});
}

module.exports.addNewItem = function(body, callback){
	db.query('SELECT * FROM item WHERE name = ?', body.name, (err, rows) => {
		if (err) callback(err);
		else if (rows[0]!==undefined){
			console.log("Item already exists");
			callback(null, "ALREADY_EXISTS");
		}
		else {
			db.query('INSERT INTO item VALUES (DEFAULT, ?, ?, ?, ?, ?)',
			[body.name, body.supplier, body.unitPrice, body.quantity, body.description], (err, rows) => {
			console.log('rows ', rows);
			if (err) callback(err);
			else callback(null, "SUCCESS");
			});
		}
	});
}

module.exports.updateItem = function(body, callback){
	db.query('UPDATE item SET name = ?, supplier = ?, unitPrice = ?, quantity = ?, description = ? WHERE itemCode = ?',
		[body.name, body.supplier, body.unitPrice, body.quantity, body.description, body.itemCode], (err, rows) => {
			console.log('rows ', rows);
			if (err) callback(err);
			else callback(null, 'SUCCESS');
		}
	);
}

module.exports.deleteItem = function(itemCode, callback){
	db.query('SELECT * FROM pr a JOIN pr_item b on a.requestID = b.requestID WHERE b.itemCode = ?', itemCode, (err, rows) => {
			console.log('rows1 ', rows.length);
			if (err) callback(err);
			else if (rows.length > 0) {
				console.log("Unable to delete item");
				callback(null, 'EXISTING_PR');
			}
			else {
				db.query('DELETE FROM item WHERE itemCode = ?', itemCode, (err, rows) => {
				console.log('rows ', rows);
				if (err) callback(err);
				else callback(null, 'DELETED');
				});
			}
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
	db.query('SELECT * FROM item WHERE itemCode = ?', itemCode, (err, rows) => {
			console.log('rows ', rows);
			if (err) callback(err);
			else callback(null, rows);		
			
		}
	);	
}

module.exports.viewItemsInPr = function (currentReqId, callback){
	db.query('SELECT a.itemCode as itemCode, a.quantity as reqQuantity, b.name as name, b.supplier as supplier, b.unitPrice as unitPrice, b.quantity as curQuantity, b.description as description FROM pr_item a, item b WHERE a.requestID = ? AND a.itemCode = b.itemCode', currentReqId, (err, rows) => {
			console.log('rows ', rows);
			console.log(err);
			if (err) callback(err);
			else callback(null, rows);		
			
		}
	);
}

module.exports.viewItemsInPo = function (currentReqId, callback){
	db.query('SELECT a.itemCode as itemCode, a.quantity as reqQuantity, b.name as name, b.supplier as supplier, b.unitPrice as unitPrice, b.quantity as curQuantity, b.description as description FROM pr_item a, item b WHERE a.requestID = ? AND a.itemCode = b.itemCode', currentReqId, (err, rows) => {
			if (err) callback(err);
			else callback(null, rows);		
		}
	);
}

module.exports.getAllDelivery = function (callback){
	db.query('SELECT * FROM delivered_mat',  (err, rows) => {
			if (err) callback(err);
			else callback(null, rows);		
		}
	);
}

module.exports.insertDelivery = function (reqId, callback){
	var date = new Date();
	db.query('INSERT INTO delivered_mat VALUES (?, ?, ?)', [reqId, null, date], (err, rows) => {
		if (err) callback(err);
		else callback(null, 'SUCCESS');		
	});
}

module.exports.findItem = function (itemName, callback){
	db.query('SELECT * FROM item WHERE name LIKE ?', itemName, (err, rows) => {
		if (err) callback(err);
		else callback(null, rows);
	});
}

module.exports.findPr = function (req_id, callback){
  const values = [`${req_id}%`];
	db.query('SELECT * FROM pr WHERE requestID LIKE ? AND dateApproved IS NULL', values, (err, rows) => {
		if (err) callback(err);
		else callback(null, rows);
	});
}