const express = require('express');
const router = express.Router();
var ctrl = require('./controller');

// displays the item's itemCode, name, quantity, description
router.get('/showItems', (req, res) => {
	ctrl.showItems((err, rows) => {
		if (err) res.status(500).json({status: 500, message: 'Server error'});
		else res.status(200).json({status: 200, data: rows, message: 'Success'});
	});		
});

// displays all columns in the item table
router.get('/showItemsNoFilter', (req, res) => {
	ctrl.showItemsNoFilter((err, rows) => {
		if (err) res.status(500).json({status: 500, message: 'Server error'});
		else res.status(200).json({status: 200, data: rows, message: 'Success'});
	});		
});

// search for items
router.get('/findItem/:item_name', (req, res) => {
	ctrl.findItem(req.params.item_name, (err, rows) => {
		if (err) res.status(500).json({status: 500, message: 'Server error'});
		else if (rows.length == 0) res.status(200).json({status: 200, data: rows, message: 'Item Not Found'});
		else{
			res.status(200).json({status: 200, data: rows, message: 'Success'});
		}
	});
});


module.exports = router;