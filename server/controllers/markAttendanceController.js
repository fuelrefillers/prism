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



  res.status(200).json({ success: true, message: 'Attendance updated successfully',attendees:(filteredListARRANGED.length),absentees:rollNumbers});
});



function getCurrentTimestamp(currentDate) {
  const year = currentDate.getFullYear();
  const month = String(currentDate.getMonth() + 1).padStart(2, '0');
  const day = String(currentDate.getDate()).padStart(2, '0');
  const hours = String(currentDate.getHours()).padStart(2, '0');
  const minutes = String(currentDate.getMinutes()).padStart(2, '0');
  const seconds = String(currentDate.getSeconds()).padStart(2, '0');
  const milliseconds = String(currentDate.getMilliseconds()).padStart(6, '0');

  const formattedDate = `${year}-${month}-${day}`;

  return formattedDate;
}

function getCurrentPeriod(periods) {
  const currentTime = new Date(2024, 1, 19, 11, 0, 0).toLocaleTimeString('en-US', { hour: '2-digit', minute: '2-digit' }); // Format time for HH:MM comparison
  
  return periods.find(period => {
    const startTime = new Date('2024-02-19 ' + period.StartTime).toLocaleTimeString('en-US', { hour: '2-digit', minute: '2-digit' });
    const endTime = new Date('2024-02-19 ' + period.EndTime).toLocaleTimeString('en-US', { hour: '2-digit', minute: '2-digit' });
    console.log(currentTime,startTime,endTime);
    return (currentTime >= startTime && currentTime <= endTime);
  });
}

const AttendanceHistoryManuplation = asyncHandler(async(req,res,rollNumbers)=>{
  console.log(new Date());
rollNumbers.map(async(rno)=>{
    const rollNumberEntry = await AttendanceHistory.findOne({
      RollNumber: rno,
    });
    const currentPeriod = getCurrentPeriod(rollNumberEntry.TimeTable.find(entry => entry.date === '2024-02-12').Periods);

    if (currentPeriod) {
      console.log(currentPeriod);
      currentPeriod.present = false;
    } else {
      console.log("No period found for the current time.");
    }

    await rollNumberEntry.save();
});

});
  

  
 
module.exports = {setAttendance}; 