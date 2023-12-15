const mongoose = require("mongoose");

const userDataSchema = mongoose.Schema({
    // user_id :{
    //     type:mongoose.Schema.Types.ObjectId,
    //     required:true,
    //     ref:users,
    // },
    StudentName:{
        type:String,
        required:true,
    },
    StudentPhnNo:{
        type:Number,
        required:true,
    },
    StudentEmail:{
        type:String,
        required:true,
    },
    FatherName:{
        type:String,
        required:true,
    },
    FatherPhnNo:{
        type:Number,
        required:true,
    },
    FatherEmail:{
        type:String,
        required:true,
    },
    MotherName:{
        type:String,
        required:true,
    },
    MotherPhnNo:{
        type:Number,
        required:true,
    },
    MotherEmail:{
        type:String,
    },
    RollNo:{
        type:String,
        required:true,
    },
    ImageUrl:{
        type:String,
        required:true,
    },
    Semester:{
        type:Number,
        required:true,
    },
    Department:{
        type:String,
        required:true,
    },
    Section:{
        type:String,
        required:true,
    },
    UserName:{
        type:String,
        required:true,
    },
    Password:{
        type:String,
        required:true,
    },
    Actions:{
        type:String,
        required:true,
    },
    FeeStatus:{
        type:Boolean,
        required:true,
    }
});

module.exports = mongoose.model("UserData",userDataSchema);