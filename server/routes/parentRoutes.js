const express = require("express");
const { parentLogin } = require("../controllers/parentController");
const validateToken = require("../middleware/tokenValidator");

const router = express.Router();

router.route("/login").post(parentLogin);

module.exports = router;