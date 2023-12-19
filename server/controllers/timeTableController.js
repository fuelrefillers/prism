const express = require("express");
const multer = require("multer");
const path = require("path");
const router = express.Router();
const TimeTable = require("../models/timeTableModel");
const asynchandler = require("express-async-handler");
const { log } = require("console");

const storage = multer.diskStorage({
     destination: (req, file, cb) => {
            cb(null, './upload/timetable');
     },
    filename: (req, file, cb) => {
            return cb(null, `${file.fieldname}_${Date.now()}${path.extname(file.originalname)}`);
    }
})

const upload = multer({storage: storage,});

router.post("/upload", upload.single('timetablepdf'), asynchandler(async(req, res) => {
    const {TimeTableTitle,department,regulation}=req.body;
    const file1 = req.file;
    const TimeTableRes = await TimeTable.create({TimeTableTitle:TimeTableTitle,Department:department,Regulation:regulation,TimeTableUrl:`http://10.0.2.2:3000/upload/timetable/${file1.filename}`});
    res.status(200).json(TimeTableRes);
}));

router.get("/getTimetable",asynchandler(async(req,res)=>{
    filter = {};
    if(req.query){
        const { regulation, department } = req.query;
        filter = { Regulation: regulation, Department: department };
    }
    const response = await TimeTable.find(filter);

    res.status(200).json(response);
}))



module.exports = router;