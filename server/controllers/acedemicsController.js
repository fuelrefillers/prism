const asynchandler = require("express-async-handler");
const Semester = require("../models/acedemicsModel");

const addSemesterData = asynchandler(async(req,res)=>{
    const newData =await Semester.create(req.body);
    res.json(newData);
});

const updateSemesterData = asynchandler(async(req,res)=>{
    let filter = {};
    const { regulation, semester,month} = req.query;
    if(req.query){
        //const { regulation, semester,month} = req.query;
        filter = {Regulation: regulation, Semester: semester}
    }
    let monthIndex =parseInt(month)-1;
    const { intValue } = req.body;
    

    // const Data = await Semester.findOne(filter);
    // let newWorkingDaysForMonth = Data.WorkingDaysForMonth; 
    // let newHolidaysForMonth = Data.HolidaysForMonth;
    // console.log(newWorkingDaysForMonth,newHolidaysForMonth,Data.TotalWorkingDaysForSem,Data.TotalNumberOfHolidays);

    // newHolidaysForMonth[monthIndex] = newHolidaysForMonth[monthIndex] + intValue;
    // newWorkingDaysForMonth[monthIndex] = newWorkingDaysForMonth[monthIndex] - intValue;
    // Data.TotalWorkingDaysForSem = Data.TotalWorkingDaysForSem - intValue;
    // Data.TotalNumberOfHolidays = Data.TotalNumberOfHolidays + intValue;
    // Data.HolidaysForMonth = newHolidaysForMonth;
    // Data.WorkingDaysForMonth = newWorkingDaysForMonth;

    // res.json(Data);


    const semesterData = await Semester.findOne(filter);
        if (!semesterData) {
            return res.status(404).json({ error: 'Semester data not found' });
        }

        // Update the values in the document
        semesterData.HolidaysForMonth[monthIndex] += intValue;
        semesterData.WorkingDaysForMonth[monthIndex] -= intValue;
        semesterData.TotalWorkingDaysForSem -= intValue;
        semesterData.TotalNumberOfHolidays += intValue;

        // Save the updated document back to the database
        await semesterData.save();

        res.json(semesterData);
});


const fetchAcademicmonths = asynchandler(async(req,res)=>{
    let filter = {};
    const { regulation, semester} = req.query;
    if(req.query){
        filter = {Regulation: regulation, Semester: semester}
    }

    const Data = await Semester.findOne(filter);

    res.json(Data.TotalNumberOfMonths);
})

module.exports = {addSemesterData,updateSemesterData,fetchAcademicmonths};