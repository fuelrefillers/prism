const asyncHandler = require("express-async-handler");
const attenn = require("../models/attendanceModel");
const UserData = require("../models/userDetailsModel");
const AttendanceHistory = require("../models/attendanceHistory");


const setAttendance = asyncHandler(async (req, res) => {
  let filter = {};
  
  if(req.query){
    const rollNoRegExp = new RegExp(`^${req.query.regulation}`);
    filter = {Section:req.query.section,Department:req.query.department,RollNo:rollNoRegExp};
  }
  console.log(filter);

    const { rollNumbers } = req.body;
    const rollNumberslist = await UserData.find(filter,{RollNo:1,_id:0});
    rollNumbersToRemove = rollNumbers


    const filteredList = rollNumberslist.filter(item => !rollNumbersToRemove.some(rollNo => rollNo === item.RollNo));

    const filteredListARRANGED = filteredList.map(item => item.RollNo);


    const currentTime = new Date();
  const hours = currentTime.getHours();
  const minutes = currentTime.getMinutes();
    
  let updateObject = {};

  if (hours < 13 || (hours === 13 && minutes < 20)) {
    // If the current time is before 1:20 PM, set MorningAttended to 1
    updateObject = [{ $set: { 'CurrentDay.MorningAttended': 1 } }];
  } else {
    // If the current time is 1:20 PM or later, set AfternoonAttended to 1
    updateObject = [{ $set: { 'CurrentDay.AfternoonAttended': 1 } }];
  }

  // Update attendance for each student
  for (const student of filteredListARRANGED) {    
    const user = await attenn.findOneAndUpdate(
      { RollNo: student },
      updateObject
    );
  }
    
    for (const student of rollNumbers) {
      const user = await attenn.findOneAndUpdate(
        { RollNo: student },
        { 
            $inc: { 'SemesterData.ClassesAttendedForSem': -1 ,'MonthlyData.ClassesAttendedForMonth': -1 },
        }
      );
    }
    AttendanceHistoryManuplation(req,res,rollNumbers);
    // console.log(filteredListARRANGED);



    res.status(200).json({ success: true, message: 'Attendance updated successfully',attendees:(filteredListARRANGED.length),absentees:rollNumbers});
  });

const AttendanceHistoryManuplation = asyncHandler(async(req,res,rollNumbers)=>{
  for(rno in rollNumbers){
    const rollNumberEntry = await RollNumber.findOne({
      RollNumber: rollNumber,
      "TimeTable.date": date
    });
  }
});
  
// setAttendance();
  
 
module.exports = {setAttendance}; 