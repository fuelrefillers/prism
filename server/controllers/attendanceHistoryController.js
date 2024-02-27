const asyncHandler = require("express-async-handler");
const UserDetails = require("../models/userDetailsModel");
const TimeTable = require("../models/TTM"); // Assuming your time table model is named TTM
const AttendanceHistory = require("../models/attendanceHistory");
const xlsx = require('xlsx');




function getDayOfWeek(date) {
  const days = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
  return days[date.getDay()];
}

function getCurrentTimestamp(currentDate) {
  // const currentDate = new Date();
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

const assignAttendance = asyncHandler(async (req, res) => {
  const startDate = new Date("2024-02-05");
  const endDate = new Date("2024-06-17");

  // Fetch all students
  const allStudents = await UserDetails.find();

  for (const student of allStudents) {
    // Fetch the section timetable
    const sectionTimetable = await TimeTable.findOne({ "Section.Name": student.Section });

    if (!sectionTimetable) {
      console.log("Section timetable not found for student", student.RollNo);
      continue;
    }

    const attendanceEntry = new AttendanceHistory({
      Regulation: "MR21",
      Department: student.Department,
      Section: student.Section,
      RollNumber: student.RollNo,
      TimeTable: []
    });

    for (let currentDate = new Date(startDate); currentDate <= endDate; currentDate.setDate(currentDate.getDate() + 1)) {
      const dayOfWeek = getDayOfWeek(currentDate);
      if (dayOfWeek === 'Sunday') {
        continue;
      }

      const timetableEntry = sectionTimetable.Section.TimeTable.find(entry => entry.Day === dayOfWeek);

      if (!timetableEntry) {
        console.log("Timetable entry not found for", student.RollNo, "on", dayOfWeek);
        continue;
      }
      
      attendanceEntry.TimeTable.push({
        date: getCurrentTimestamp(currentDate),
        day: dayOfWeek,
        Periods: timetableEntry.Periods.map(period => ({
          ...period,
          present: true
        }))
      });

      // console.log(currentDate);
    }

    
    await attendanceEntry.save();
    // console.log("Attendance entry created for", student.RollNo, "with multiple days");
  }

  res.json({ message: "Attendance assigned successfully" });
});






// const targetDate = '2024-02-12';
// const specificRollNumber = '21J41A05R5'; // Replace with actual roll number

// AttendanceHistory.findOne({ RollNumber: specificRollNumber })
//   .then(doc => {
//     if (doc) {
//       const timetableToUpdate = doc.TimeTable.find(timetable => timetable.date === targetDate);
//       console.log(timetableToUpdate);
//       if (timetableToUpdate) {
//         const noOfPeriods = timetableToUpdate.Periods.length;
//         timetableToUpdate.PresentStatus = timetableToUpdate.Periods.reduce((sum, period) => sum + (period.present ? 1 : 0), 0) / noOfPeriods;
        
//         console.log("noOfPeriods : ",noOfPeriods);
//         // Optionally save the updated document:
//         doc.save()
//           .then(() => console.log('PresentStatus updated successfully!'))
//           .catch(error => console.error('Error saving document:', error));
//         console.log('Updated PresentStatus:', timetableToUpdate.PresentStatus);
//       } else {
//         console.log('TimeTable not found for the specified date.');
//       }
//     } else {
//       console.log('Document not found for the specified roll number.');
//     }
//   })
//   .catch(error => console.error('Error retrieving document:', error));





const DataToExcel = asyncHandler(async(req,res)=>{
  const doc = await  AttendanceHistory.find();
  const startDate = '2024-02-12';
  const endDate = '2024-02-29';



  const attendanceData = await AttendanceHistory.find({
    'TimeTable.date': { $gte: startDate, $lte: endDate }
  });
  const sheetData = [];

  const uniqueDates = new Set();
    attendanceData.forEach(doc => {
      doc.TimeTable.forEach(timetable => {
        if (timetable.date >= startDate && timetable.date <= endDate) {
          uniqueDates.add(timetable.date);
        }
      });
    });


    const dateColumns = [...uniqueDates].sort((a, b) => new Date(a) - new Date(b)); 

    const columnHeaders = ['RollNumber',"Regulation","Department","Section", ...dateColumns];
    sheetData.push(columnHeaders);

    attendanceData.forEach(doc => {
      const rowData = [doc.RollNumber,doc.Regulation,doc.Department,doc.Section];

      dateColumns.forEach(date => {
        const foundTimetable = doc.TimeTable.find(timetable => timetable.date === date);
        rowData.push(foundTimetable ? foundTimetable.day : null); 
      });

      sheetData.push(rowData);
    });

    // console.log(sheetData);

// try{
//   const worksheet = xlsx.utils.json_to_sheet(sheetData);
//   console.log(worksheet);
//   const workbook = xlsx.utils.book_new();

//   xlsx.utils.sheet_add_aoa(workbook, worksheet, 'Attendance');
//   console.log("hoii");
//   // Save the Excel file
//   xlsx.writeFile(workbook, `attendance_data_${startDate}_${endDate}.xlsx`); // Include dates in filename
//   console.log('Excel sheet generated successfully!');
//   console.log("hoi");
// }
// catch(err){
//   console.log(err);
// }

const workbook = xlsx.utils.book_new();

// Convert the worksheet data to a worksheet object
const worksheet = xlsx.utils.json_to_sheet(sheetData);

// Add the worksheet to the workbook
xlsx.utils.book_append_sheet(workbook, worksheet, 'Attendance');

// Save the Excel file
xlsx.writeFile(workbook, 'attendance.xlsx');

console.log('Excel sheet generated successfully!');



// const filteredData = Object.keys(data)
//   .filter(key => !/^[A-Z]+\d+$/.test(key)) // Filter out keys like "A1", "B1", etc.
//   .reduce((obj, key) => {
//     obj[key] = data[key];
//     return obj;
//   }, {});

// // Now, pass filteredData to xlsx.utils.sheet_add_aoa()


});

// DataToExcel();












module.exports = { assignAttendance };
