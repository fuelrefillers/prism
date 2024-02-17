const express = require("express");
const { addSemesterData, updateSemesterData, fetchAcademicmonths } = require("../controllers/acedemicsController");
const router = express.Router();

router.route("/").post(addSemesterData);
router.route("/update").post(updateSemesterData);
router.route("/fetch").get(fetchAcademicmonths);


module.exports = router;