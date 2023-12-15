const mongoose = require("mongoose");

const attendanceSchema = mongoose.Schema({
    RollNo: {
        type: String,
        required: true,
        unique: true,
      },
      SemesterData: {
        TotalForSem: { type: Number, required: true },
        ClassesAttendedForSem: { type: Number, required: true },
        HolidaysForSem: { type: Number, required: true },
        SemPercentage: { type: Number },
        TotalDaysAbsentForSem: { type: Number, required: true },
      },
      MonthlyData: {
        TotalForMonth: { type: Number, required: true },
        ClassesAttendedForMonth: { type: Number, required: true },
        HolidaysForMonth: { type: Number, required: true },
        MonthlyPercentage: { type: Number },
        TotalDaysAbsentForMonth: { type: Number, required: true },
      },
      CurrentDay:{
        MorningAttended: { type: Number, required: true },
        AfternoonAttended: { type: Number, required: true },
      }

    
});


module.exports = mongoose.model("Attendance",attendanceSchema);