const mongoose = require("mongoose");

const TimeTableSchema = mongoose.Schema({
    Regulation: {
      title: { type: String, required: true },
      active: { type: Boolean, default: true }
    },
    Semester: {
      name: { type: String, required: true },
      start_date: { type: Date, required: true },
      end_date: { type: Date, required: true }
    },
    Department: {
      name: { type: String, required: true }
    },
    Section: {
      Name: { type: String, required: true },
      TimeTable: [
        {
          Day: { type: String, required: true },
          Periods: [
            {
              StartTime: { type: String, required: true },
              EndTime: { type: String, required: true },
              ClassType: { type: String, required: true },
              ClassDuration: { type: Number, required: true }
            }
          ]
        }
      ]
    },
    created_at: { type: Date, default: Date.now },
    updated_at: { type: Date, default: Date.now }
  });
 
module.exports = mongoose.model("TTM",TimeTableSchema);


