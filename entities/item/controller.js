const db = require('../../database/connection');

module.exports.showItems = function (callback) {
	db.query('SELECT itemCode, name, quantity, description FROM item ORDER BY name', (err, rows) => {
		if (err) callback(err);
		else callback(null, rows);
	});
}

module.exports.showItemsNoFilter = function (callback){
	db.query('SELECT * FROM item ORDER BY name', (err, rows) => {
		if (err) callback(err);
		else callback(null, rows);
	});
}


module.exports.findItem = function (itemName, callback){
  const values = [`%${itemName}%`];

	db.query('SELECT * FROM item WHERE name LIKE ?', values, (err, rows) => {
		if (err) callback(err);
		else callback(null, rows);
	});
}