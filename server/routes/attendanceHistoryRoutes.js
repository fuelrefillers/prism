const express = require("express");
const { assignAttendance } = require("../controllers/attendanceHistoryController");

const router = express.Router();

router.route("/").get(assignAttendance);

module.exports = router;