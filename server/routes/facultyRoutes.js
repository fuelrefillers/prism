const express = require("express");
const { createFaculty, loginFaculty, getFacultyData } = require("../controllers/facultyConttroller");
const validateToken = require("../middleware/tokenValidator");
const router = express.Router();

router.route("/create").post(createFaculty);
router.route("/login").post(loginFaculty);
router.route("/getFacultydata").get(validateToken, getFacultyData);

module.exports = router;