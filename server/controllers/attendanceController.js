const asyncHandler = require("express-async-handler");
const attenn = require("../models/attendanceModel");

const createAttendance = asyncHandler(async(req,res)=>{
    const atten = await attenn.create(req.body);
    res.status(200).json(atten);
});

const getAttendance = asyncHandler(async(req,res)=>{
    // console.log({RollNo:req.user});
    const userAtten = await attenn.findOne({RollNo:req.user.roolno});
    // console.log(userAtten);
    //res.status(200).json({SemPercentage:userAtten.SemesterData.SemPercentage,MonthlyPercentage:userAtten.MonthlyData.MonthlyPercentage,DayPresent:userAtten.CurrentDay.MorningAttended+userAtten.CurrentDay.AfternoonAttended});
    res.status(200).json({SemPercentage:userAtten.SemesterData.SemPercentage,MonthlyPercentage:userAtten.MonthlyData.MonthlyPercentage,DayPresent:userAtten.CurrentDay.MorningAttended+userAtten.CurrentDay.AfternoonAttended});
    
});



// const updateAttendance = asyncHandler(async(req,res)=>{
//     const updated = await Attendance.findOneAndUpdate(,req.body)
// });

module.exports = {createAttendance,getAttendance};