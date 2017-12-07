const express = require('express');
const router = express.Router();

const auth = require('./entities/auth/router');
const user_admin = require ('./entities/user_admin/router');
const user_normal = require('./entities/user_normal/router');
const item = require('./entities/item/router');

router.use(auth); 
/*
router.use((req, res, next)=> {
	console.log(req.session);
	if (req.session.username) return next();
	else res.status(401).json({status: 401, message: 'Must be logged in'});
});
*/

router.use('/item', item);
router.use('/user_admin', user_admin);
router.use('/user_normal', user_normal);

module.exports = router;