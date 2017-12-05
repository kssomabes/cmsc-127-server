const express = require('express');
const router = express.Router();
var ctrl = require('./controller');

router.get('/getMyPurchReq', (req, res) => {
	ctrl.getMyPurchReq(req.session.user.userID, (err, rows) => {
		console.log(req.session.user.username);
		if (err) res.status(500).json({status: 500, message: 'Server error'});
		else res.status(200).json({status: 200, data: rows, message: 'Success'});
	});
	
});

router.get('/getMyPurchOrder', (req, res) => {
	ctrl.getMyPurchOrder(req.session.user.userID, (err, rows) => {
		console.log(req.session.user.username);
		if (err) res.status(500).json({status: 500, message: 'Server error'});
		else res.status(200).json({status: 200, data: rows, message: 'Success'});

	});
});

module.exports = router;