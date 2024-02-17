const express = require("express");
const { setTimeTable } = require("../controllers/TimeTableController1");

const router = express.Router();

router.route("/ab").post(setTimeTable);

module.exports =  router; 