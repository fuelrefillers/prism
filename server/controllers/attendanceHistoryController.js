const asyncHandler = require("express-async-handler");
const UserDetails = require("../models/userDetailsModel");
const TimeTable = require("../models/TTM"); // Assuming your time table model is named TTM
const AttendanceHistory = require("../models/attendanceHistory");

function getDayOfWeek(date) {
  const days = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
  return days[date.getDay()];
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
        date: currentDate,
        day: dayOfWeek,
        Periods: timetableEntry.Periods.map(period => ({
          ...period,
          present: true
        }))
      });
    }

    await attendanceEntry.save();
    console.log("Attendance entry created for", student.RollNo, "with multiple days");
  }

  res.json({ message: "Attendance assigned successfully" });
});

module.exports = { assignAttendance };
