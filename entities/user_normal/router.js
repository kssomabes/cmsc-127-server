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

router.post('/deletePurchReq', (req, res) => {
	ctrl.deletePurchReq(req.body.requestID, (err, rows) => {
		console.log(req.body.requestID);
		if (err) res.status(500).json({status: 500, message: 'Server error'});
		else res.status(200).json({status: 200, data: rows, message: 'Success'});

	});
});

router.post('/addNewPurchReq', (req, res) => {
	ctrl.addNewPurchReq(req.body, (err, rows) => {
		console.log(req.body);
		if (err) res.status(500).json({status: 500, message: 'Server error'});
		else res.status(200).json({status: 200, data: rows, message: 'Success'});

	});
	ctrl.addPurchItem(req.body, (err, rows) => {
		console.log(req.body);
		if (err) res.status(500).json({status: 500, message: 'Server error'});
		else res.status(200).json({status: 200, data: rows, message: 'Success'});

	});	
});

router.post('/updatePurchReq', (req, res) => {
	ctrl.updatePurchReq(req.body, (err, rows) => {
		console.log(req.body);
		if (err) res.status(500).json({status: 500, message: 'Server error'});
		else res.status(200).json({status: 200, data: rows, message: 'Success'});

	});
});

module.exports = router;