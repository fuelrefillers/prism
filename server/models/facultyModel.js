const mongoose = require("mongoose");

const facultySchema = mongoose.Schema({
    FacultyId:{
        type:String,
        required:true,
    },
    FacultyName:{
        type:String,
        required:true,
    },
    FacultyDesignation:{
        type:String,
        required:true,
    },
    FacultyPhnNo:{
        type:String,
        required:true,
    },
    FacultyDepartment:{
        type:String,required:true,
    },
    Classes:[{
        Department : {type:String,required:true},
        Section : {type:String,required:true},
        Regulation : {type:String,required:true},
        Year : {type:String,required:true}
    }],
    SubstitueInfo:[{
        Date:{type:String},
        Day:{type:String},
        StartTime:{type:String},
        EndTime:{type:String},
        Department : {type:String},
        Section : {type:String},
        Regulation : {type:String},
        Year : {type:String},
        OriginalLecturer : {type:String},
    }],
    IsAdmin:{
        type:Boolean,
        required:true,
    },
    UserName:{
        type:String,
        required:true,
    },
    Password:{
        type:String,
        required:true,
    }
});

module.exports = mongoose.model("Faculty",facultySchema);