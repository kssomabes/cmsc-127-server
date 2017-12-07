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


module.exports.deletePurchReq = function(requestID, userID, callback){
	//Checks first if purch req is not approved yet
	db.query('SELECT * FROM pr WHERE requestID = ? AND userID = ? AND dateApproved IS NULL',
		[requestID, userID], (err, rows) => {
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


module.exports.updatePurchReq = function(body, userID, callback){
	db.query('SELECT * FROM pr WHERE requestID = ? AND userID = ? AND dateApproved IS NULL', [body.requestID, userID], (err, rows) => {
		if (err) callback(err);
		else if (rows[0]===undefined) {
			console.log("Cannot update");
			callback(rows);
		}
		else{
			db.query('UPDATE pr_item SET itemCode = ?, quantity = ? WHERE requestID = ?',
			[body.itemCode, body.quantity, body.requestID], (err, rows) => {
				console.log('rows ', rows);
				if (err) callback(err);
				else callback(null, rows);
			});
		}
	});
}

module.exports.addNewPurchReq = function(user, callback){
	const date = new Date();
	
	db.query('INSERT INTO pr VALUES (default, ?, ?, ?, ?)',
		[user, date, null, null], (err, rows) => {
		console.log('rows ', rows)
		if (err) callback(err);
		else callback(null, rows);
		}
	);
}

module.exports.addPurchItem = function(requestID, array, callback){
	console.log('adding items');
	// var itemCode, quantity;
	for(var i in array){
		// itemCode = body.itemCode[i];
		// quantity = body.quantity[i];
		console.log(array[i].itemCode);
		db.query('INSERT INTO pr_item VALUES (?, ?, ?)',
		[requestID, array[i].itemCode, array[i].quantity], (err, rows) => {
		console.log('rows ', rows);
		if (err) callback(err);
		else console.log('Added to pr'); //callback(null, rows);
		});
	}
}

module.exports.viewItemsInPr = function (currentReqId, userID, callback){
	db.query('SELECT * FROM pr WHERE requestID = ? AND userID = ? AND dateApproved IS NULL', [currentReqId, userID], (err, rows) => {
		console.log('rows 1 ', rows);
		console.log(err);
		if (err) callback(err);
		else if (rows===undefined || rows.length == 0) {
			console.log("No rows found");
			callback(rows);
		}
		else {
			db.query('SELECT a.itemCode as itemCode, a.quantity as reqQuantity, b.name as name, b.supplier as supplier, b.unitPrice as unitPrice, b.quantity as curQuantity, b.description as description FROM pr_item a, item b WHERE a.requestID = ? AND a.itemCode = b.itemCode', currentReqId, (err, rows) => {
				console.log('rows 2', rows);
				console.log(err);
				if (err) callback(err);
				else callback(null, rows);
			});
		}
	});
}

module.exports.viewItemsInPo = function (currentReqId, userID, callback){
	db.query('SELECT * FROM pr WHERE requestID = ? AND userID = ? AND dateApproved IS NOT NULL', [currentReqId, userID], (err, rows) => {
		console.log(err);
		console.log('rows 1', rows);
		if (err) callback(err);
		else if (rows === undefined || rows.length == 0) {
			console.log("No rows found");
			callback(null, rows);
		}
		else {
			db.query('SELECT a.itemCode as itemCode, a.quantity as reqQuantity, b.name as name, b.supplier as supplier, b.unitPrice as unitPrice, b.quantity as curQuantity, b.description as description FROM pr_item a, item b WHERE a.requestID = ? AND a.itemCode = b.itemCode', currentReqId, (err, rows) => {
				console.log('rows 2', rows);
				console.log(err);
				if (err) callback(err);
				else callback(null, rows);
			});
		}
	});
}