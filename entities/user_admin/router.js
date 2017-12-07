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

router.get('/getItem/:item_code', (req, res) => {
	ctrl.getItem(req.params.item_code, (err, rows) => {
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
		console.log('aaaaa');
			console.log(req.body);
	ctrl.addNewItem(req.body, (err, rows) => {
		console.log(req.body);
		console.log(err);
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

router.get('/prNjoinItem', (req, res) => {
	ctrl.prNjoinItem((err, rows) => {
		if (err) res.status(500).json({status: 500, message: 'Server error'});
		else{
			res.status(200).json({status: 200, data: rows, message: 'Success'});
		}
	});
});

router.get('/poNjoinItem', (req, res) => {
	ctrl.poNjoinItem((err, rows) => {
		if (err) res.status(500).json({status: 500, message: 'Server error'});
		else{
			res.status(200).json({status: 200, data: rows, message: 'Success'});
		}
	});
});

router.put('/approve/:req_id', (req, res) => {
	ctrl.approvePurchReq(req.params.req_id, req.session.user.userID, (err, rows) => {
		if (err) res.status(500).json({status: 500, message: 'Server error'});
		else{
			res.status(200).json({status: 200, data: rows, message: 'Success'});
		}
	});
});

router.get('/viewItemsInPr/:currentReqId', (req, res) => {
	ctrl.viewItemsInPr(req.params.currentReqId, (err, rows) => {
		if (err) res.status(500).json({status: 500, message: 'Server error'});
		else{
			res.status(200).json({status: 200, data: rows, message: 'Success'});
		}
		
	});
});

router.get('/viewItemsInPo/:currentReqId', (req, res) => {
	ctrl.viewItemsInPo(req.params.currentReqId, (err, rows) => {
		if (err) res.status(500).json({status: 500, message: 'Server error'});
		else{
			res.status(200).json({status: 200, data: rows, message: 'Success'});
		}
		
	});
});


module.exports = router;