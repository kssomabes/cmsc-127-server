const express = require('express');
const router = express.Router();
var ctrl = require('./controller');

router.get('/showItems', (req, res) => {
	console.log('show items');
	ctrl.showItems((err, rows) => {
		if (err) res.status(500).json({status: 500, message: 'Server error'});
		else res.status(200).json({status: 200, data: rows, message: 'Success'});
	});		
});

router.get('/showItemsNoFilter', (req, res) => {
	console.log('show items');
	ctrl.showItemsNoFilter((err, rows) => {
		console.log(rows);
		if (err) res.status(500).json({status: 500, message: 'Server error'});
		else res.status(200).json({status: 200, data: rows, message: 'Success'});
	});		
});

module.exports = router;