const db = require('../../database/connection');

module.exports.showItems = function (callback) {
	db.query('SELECT itemCode, name FROM item', (err, rows) => {
		if (err) callback(err);
		else callback(null, rows);
	});
}