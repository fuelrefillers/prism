const mongoose = require("mongoose");

const TimeTableSchema = mongoose.Schema({
    Regulation: {
      title: { type: String, required: true },
      active: { type: Boolean, default: true }
    },
    // Semester: {
    //   name: { type: String, required: true },
    //   start_date: { type: Date, required: true },
    //   end_date: { type: Date, required: true }
    // },
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
              ClassType:{ type: String, required: true},
              ClassName:{ type: String, required: true},
              SubjectName:{ type: String, required: true},
              Subjectcode:{ type: String, required: true},
              LecturerName : { type: String, required: true },
              LecturerId : {type: String, required: true},
              LecturerNumber : {type: String, required: true},
              Substitute : {type: Boolean,default:false, required: true}, 
              SubstituteId : {type: String},
              SubstituteName:{type: String},
            }
          ]
        }
      ]
    },
    created_at: { type: Date, default: Date.now },
    updated_at: { type: Date, default: Date.now }
  });
 
module.exports = mongoose.model("TTM",TimeTableSchema);


