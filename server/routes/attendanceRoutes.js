const express = require("express");
const validateToken = require("../middleware/tokenValidator");
const { createAttendance, getAttendance } = require("../controllers/attendanceController");
const { setAttendance } = require("../controllers/markAttendanceController");
const { updatePercentageAtMidnight } = require("../controllers/attendanceDBcontroller");

const router = express.Router();

router.route("/createatt").post(createAttendance);
router.route("/getatten").get(validateToken,getAttendance);
router.route("/setAttendance").post(setAttendance);
router.route("/updateattendanceatmidnight").get(updatePercentageAtMidnight);

module.exports = router;