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