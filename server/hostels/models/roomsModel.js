const mongoose = require("mongoose");

const hostelRoomsSchema = mongoose.Schema({
    type:{
        type:String,
        required:true,
    },
    floorNumber:{
        type:Number,
        required:true
    },
    roomNumber:{
        type:Number,
        required:true 
    },
    beds:[{
        bedNumber:{
           type:Number,
           required:true
        },
        isBooked:{
            type:bool,
            required:true,
            default:false,
        },
        bookedBy:{
            type:String,
            required:true,
            default:"No one Booked"
        },
        bookedById:{
            type:String,
            required:true,
            default:"No one Booked"
        }
    }]
});

module.exports = mongoose.Schema("hostelRooms",hostelRoomsSchema);