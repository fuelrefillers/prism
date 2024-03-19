const express = require("express");
const { setTimeTable, getTimeTable } = require("../controllers/TimeTableController1");

const router = express.Router();

router.route("/ab").post(setTimeTable);
router.route("/getsectionSpecificTimeTable").get(getTimeTable);



module.exports =  router; 