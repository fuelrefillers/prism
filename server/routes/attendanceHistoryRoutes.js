const express = require("express");
const { assignAttendance, DataToExcel, dataToExcelForIndividualClassSubjects } = require("../controllers/attendanceHistoryController");

const router = express.Router();

router.route("/").get(assignAttendance);
router.route("/downloadAttendance").post(DataToExcel);
router.route("/downloadSubjectWiseAttendance").get(dataToExcelForIndividualClassSubjects);

module.exports = router;