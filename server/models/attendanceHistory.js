const mongoose = require("mongoose");

const RollNumberSchema = mongoose.Schema({
    Regulation : {type: String, required: true},
    Department : {type: String, required: true},
    Section: { type: String, required: true},
    RollNumber: {type: String, required: true},
    TimeTable: [{
        date: {type: Date, required: true},
        day: {type: String, required: true},
        Periods: [
          {
            StartTime: {type: String, required: true},
            EndTime: {type: String, required: true},
            ClassType: {type: String, required: true},
            ClassDuration: {type: Number, required: true},
            present: {type: Boolean, required: true} 
          }
        ]
    }],
    created_at: { type: Date, default: Date.now },
    updated_at: { type: Date, default: Date.now }
});

module.exports = mongoose.model("AttendanceHistory",RollNumberSchema);
