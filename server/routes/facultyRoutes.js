const express = require("express");
const { createFaculty, loginFaculty, getFacultyData, getFacultyByDepartment } = require("../controllers/facultyConttroller");
const validateToken = require("../middleware/tokenValidator");
const { AssignSubstitute, settingSubstitute } = require("../controllers/assignSubstituteController");
const router = express.Router();

router.route("/create").post(createFaculty);
router.route("/login").post(loginFaculty);
router.route("/getFacultydata").get(validateToken, getFacultyData);
router.route("/getDepartmentVise").get(getFacultyByDepartment);


router.route("/assignsubstitute").get(AssignSubstitute);
router.route("/settSubstitute").post(settingSubstitute);
module.exports = router;