const express = require('express');
const router = express.Router();
var ctrl = require('./controller');

// view all admin users
router.get('/', (req, res) => {
	ctrl.getAll((err, rows) => {
		if (err) res.status(500).json({status: 500, message: 'Server error'});
		else{
			res.status(200).json({status: 200, data: rows, message: 'S'});
		}
	});
});	

// view all purchreq
router.get('/getAllPurchReq', (req, res) => {
	ctrl.getAllPurchReq((err, rows) => {

		if (err) res.status(500).json({status: 500, message: 'Server error'});
		else{
			res.status(200).json({status: 200, data: rows, message: 'Success'});
		}

	});
});

// view all unapproved purchreq
router.get('/getAllPurchOrder', (req, res) => {
	ctrl.getAllPurchOrder((err, rows) => {

		if (err) res.status(500).json({status: 500, message: 'Server error'});
		else{
			res.status(200).json({status: 200, data: rows, message: 'Success'});
		}

	});
});

// view an item
router.get('/getItem/:item_code', (req, res) => {
	ctrl.getItem(req.params.item_code, (err, rows) => {
		if (err) res.status(500).json({status: 500, message: 'Server error'});
		else{
			res.status(200).json({status: 200, data: rows, message: 'Success'});
		}
		
	});
});

// delete a purchreq
router.delete('/deletePurchReq', (req, res) => {
	ctrl.deletePurchReq(req.body.requestID, (err, rows) => {
		console.log(req.body.requestID);
		if (err) res.status(500).json({status: 500, message: 'Server error'});
		else res.status(200).json({status: 200, data: rows, message: 'Success'});

	});
});

// add new item to inventory
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

// updates an item in the inventory
router.put('/updateItem', (req, res) => {

	ctrl.updateItem(req.body, (err, rows) => {
		console.log(req.body);
		if (err) res.status(500).json({status: 500, message: 'Server error'});
		else res.status(200).json({status: 200, data: rows, message: 'Success'});

	});
});

// deletes an item
router.delete('/deleteItem/:item_code', (req, res) => {
	ctrl.deleteItem(req.params.item_code, (err, rows) => {
		console.log(req.params.item_code);
		if (err) res.status(500).json({status: 500, message: 'Server error'});
		else res.status(200).json({status: 200, data: rows, message: 'Success'});

	});
});

// shows items in a purchReq
router.get('/prNjoinItem', (req, res) => {
	ctrl.prNjoinItem((err, rows) => {
		if (err) res.status(500).json({status: 500, message: 'Server error'});
		else{
			res.status(200).json({status: 200, data: rows, message: 'Success'});
		}
	});
});

// shows items in a purchOrder
router.get('/poNjoinItem', (req, res) => {
	ctrl.poNjoinItem((err, rows) => {
		if (err) res.status(500).json({status: 500, message: 'Server error'});
		else{
			res.status(200).json({status: 200, data: rows, message: 'Success'});
		}
	});
});

// approves a purchReq;
router.put('/approve/:req_id', (req, res) => {
	ctrl.approvePurchReq(req.params.req_id, req.session.user.userID, (err, rows) => {
		if (err) res.status(500).json({status: 500, message: 'Server error'});
		else{
			res.status(200).json({status: 200, data: rows, message: 'Success'});
		}
	});
});

// view all items in a purchReq
router.get('/viewItemsInPr/:currentReqId', (req, res) => {
	ctrl.viewItemsInPr(req.params.currentReqId, (err, rows) => {
		if (err) res.status(500).json({status: 500, message: 'Server error'});
		else{
			res.status(200).json({status: 200, data: rows, message: 'Success'});
		}
		
	});
});

// view all items in a purchOrder
router.get('/viewItemsInPo/:currentReqId', (req, res) => {
	ctrl.viewItemsInPo(req.params.currentReqId, (err, rows) => {
		if (err) res.status(500).json({status: 500, message: 'Server error'});
		else{
			res.status(200).json({status: 200, data: rows, message: 'Success'});
		}
		
	});
});


router.get('/getAllDelivery', (req, res) => {
	ctrl.getAllDelivery((err, rows)=> {
		if (err) res.status(500).json({status: 500, message: 'Server error'});
		else{
			res.status(200).json({status: 200, data: rows, message: 'Success'});
		}
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

// search for purchReq
router.get('/findPr/:req_id', (req, res) => {
	ctrl.findPr(req.params.req_id, (err, rows) => {
		if (err) res.status(500).json({status: 500, message: 'Server error'});
		else if (rows.length == 0) res.status(200).json({status: 200, data: rows, message: 'PurchReq Not Found'});
		else{
			res.status(200).json({status: 200, data: rows, message: 'Success'});
		}
	});
});



module.exports = router;