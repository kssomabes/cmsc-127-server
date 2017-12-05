const express = require('express');
const router = express.Router();
var ctrl = require('./controller');

router.get('/', (req, res) => {
	ctrl.getAll((err, rows) => {
		if (err) res.status(500).json({status: 500, message: 'Server error'});
		else{
			res.status(200).json({status: 200, data: rows, message: 'S'});
		}
	});
});	

router.get('/getAllPurchReq', (req, res) => {
	ctrl.getAllPurchReq((err, rows) => {

		if (err) res.status(500).json({status: 500, message: 'Server error'});
		else{
			res.status(200).json({status: 200, data: rows, message: 'Success'});
		}

	});
});

router.get('/getAllPurchOrder', (req, res) => {
	ctrl.getAllPurchOrder((err, rows) => {

		if (err) res.status(500).json({status: 500, message: 'Server error'});
		else{
			res.status(200).json({status: 200, data: rows, message: 'Success'});
		}

	});
});

router.post('/approve/:req_id', (req, res) => {
	ctrl.approvePurchReq(req.params.req_id, req.session.user.userID, (err, rows) => {
		if (err) res.status(500).json({status: 500, message: 'Server error'});
		else{
			res.status(200).json({status: 200, data: rows, message: 'Success'});
		}
		
	});
});

router.delete('/deletePurchReq', (req, res) => {
	ctrl.deletePurchReq(req.body.requestID, (err, rows) => {
		console.log(req.body.requestID);
		if (err) res.status(500).json({status: 500, message: 'Server error'});
		else res.status(200).json({status: 200, data: rows, message: 'Success'});

	});
});

router.post('/addNewItem', (req, res) => {
	ctrl.addNewItem(req.body, (err, rows) => {
		console.log(req.body);
		if (err) res.status(500).json({status: 500, message: 'Server error'});
		else res.status(200).json({status: 200, data: rows, message: 'Success'});

	});
});

router.post('/updateItem', (req, res) => {
	ctrl.updateItem(req.body, (err, rows) => {
		console.log(req.body);
		if (err) res.status(500).json({status: 500, message: 'Server error'});
		else res.status(200).json({status: 200, data: rows, message: 'Success'});

	});
});

router.delete('/deleteItem', (req, res) => {
	ctrl.deleteItem(req.body.itemCode, (err, rows) => {
		console.log(req.body.itemCode);
		if (err) res.status(500).json({status: 500, message: 'Server error'});
		else res.status(200).json({status: 200, data: rows, message: 'Success'});

	});
});

router.get('/prNjoinPurchReq', (req, res) => {
	ctrl.prNjoinPurchReq((err, rows) => {
		if (err) res.status(500).json({status: 500, message: 'Server error'});
		else{
			res.status(200).json({status: 200, data: rows, message: 'S'});
		}
	});
});

router.get('/prNjoinPurchOrd', (req, res) => {
	ctrl.prNjoinPurchOrd((err, rows) => {
		if (err) res.status(500).json({status: 500, message: 'Server error'});
		else{
			res.status(200).json({status: 200, data: rows, message: 'S'});
		}
	});
});


module.exports = router;