const express = require('express');
const router = express.Router();
var ctrl = require('./controller');

router.post('/login', (req, res)=>{
	ctrl.logIn(req.body, (err, rows)=>{
		if (err) res.status(500).json({status: 500});
		else{ 
			
			if (!rows){
				res.status(401).json({status: 401, message: 'Invalid credentials'});
			}else{
				req.session.user = {
					userID: rows.userID,
					username: rows.username,
					accountType: rows.accountType
				}
				res.status(200).json({status: 200, user: req.session.user, message: 'Successfully logged in'});
			}
		}
	});
});

router.get('/session', (req, res)=>{

	res.status(200).json({status: 200, user: req.session.user ? req.session.user : null });

});

module.exports = router