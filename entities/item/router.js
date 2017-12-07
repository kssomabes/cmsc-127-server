const express = require('express');
const router = express.Router();
var ctrl = require('./controller');

router.get('/showItems', (req, res) => {
	ctrl.showItems((err, rows) => {
		if (err) res.status(500).json({status: 500, message: 'Server error'});
		else res.status(200).json({status: 200, data: rows, message: 'Success'});
	});		
});

module.exports = router;