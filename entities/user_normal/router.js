const express = require('express');
const router = express.Router();
var ctrl = require('./controller');

// view only the user's purchReq
router.get('/getMyPurchReq', (req, res) => {
	ctrl.getMyPurchReq(req.session.user.userID, (err, rows) => {
		console.log(req.session.user.username);
		if (err) res.status(500).json({status: 500, message: 'Server error'});
		else res.status(200).json({status: 200, data: rows, message: 'Success'});
	});
	
});

// view the user's approved purchReq
router.get('/getMyPurchOrder', (req, res) => {
	ctrl.getMyPurchOrder(req.session.user.userID, (err, rows) => {
		console.log(req.session.user.username);
		if (err) res.status(500).json({status: 500, message: 'Server error'});
		else res.status(200).json({status: 200, data: rows, message: 'Success'});

	});
});

// delete's a user's purchReq as long as it's not approved yet
router.delete('/deleteMyPR/:req_id', (req, res) => {
	ctrl.deletePurchReq(req.params.req_id, req.session.user.userID, (err, rows) => {
		if (err) res.status(500).json({status: 500, message: 'Server error'});
		else res.status(200).json({status: 200, data: rows, message: 'Success'});

	});
});

// adds a new purchReq
router.post('/addNewPurchReq', (req, res) => {
	ctrl.addNewPurchReq(req.session.user.userID, (err, rows) => {
		// var body = [ 
		// 	{ itemCode: 1, quantity: 1 }, 
		// 	{ itemCode: 30, quantity: 2 }, 
		// 	{ itemCode: 50, quantity: 3 }, 
		// ];
		if (err) res.status(500).json({status: 500, message: 'Server error'});
		else{
			var requestID = rows.insertId;

			ctrl.addPurchItem(requestID, req.body, (err2, rows2) => {
				if (err) res.status(500).json({status: 500, message: 'Server error'});
				else res.status(200).json({status: 200, data: rows2, message: 'Successfully added to pr_item'});

			});	
		}
	});
});

// updates a purchReq as long as it's not approved yet
router.put('/updatePurchReq', (req, res) => {
	ctrl.updatePurchReq(req.body, req.session.user.userID, (err, rows) => {
		console.log(req.body);
		if (err) res.status(500).json({status: 500, message: 'Server error'});
		else res.status(200).json({status: 200, data: rows, message: 'Success'});

	});
});

// view items in the user's purchReq
router.get('/viewItemsInPr/:currentReqId', (req, res) => {
	console.log(req.session);
	ctrl.viewItemsInPr(req.params.currentReqId, req.session.user.userID, (err, rows) => {
		if (err) res.status(500).json({status: 500, message: 'Server error'});
		else{
			res.status(200).json({status: 200, data: rows, message: 'Success'});
		}
		
	});
});

// view items in the user's purchOrder
router.get('/viewItemsInPo/:currentReqId', (req, res) => {
	ctrl.viewItemsInPo(req.params.currentReqId, req.session.user.userID, (err, rows) => {
		if (err) res.status(500).json({status: 500, message: 'Server error'});
		else{
			res.status(200).json({status: 200, data: rows, message: 'Success'});
		}
		
	});
});

// views delivered_mat status
router.get('/viewMyDelivery', (req, res) => {
	ctrl.viewMyDelivery(req.session.user.userID, (err, rows) => {
		if (err) res.status(500).json({status: 500, message: 'Server error'});
		else{
			res.status(200).json({status: 200, data: rows, message: 'Success'});
		}
	});
});

module.exports = router;