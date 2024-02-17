const mongoose = require("mongoose");

const aceschema = mongoose.Schema({
    Regulation:{
        type:String,
        required:true,
    },
    Semester:{
        type:Number,
        required:true,
    },
    TotalWorkingDaysForSem :{
        type:Number,
        required:true,
    },
    TotalNumberOfHolidays:{
        type:Number,
        required:true,
    },
    TotalNumberOfMonths:{
        type:Number,
        required:true,
    },
    WorkingDaysForMonth:[{
        type:Number,
        required:true,
    }],
    HolidaysForMonth:[{
        type:Number,
    }],
    
});

module.exports = mongoose.model("acedemics",aceschema);