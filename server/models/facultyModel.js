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
    Classes:[{
        type:String,
        required:true,
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