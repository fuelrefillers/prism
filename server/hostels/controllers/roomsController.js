const asyncHandler = require("express-async-handler");
const roomsModel = require("../models/roomsModel");

const setRooms = asyncHandler(async(req,res)=>{
    const newRoom = roomsModel.create(req.body);
    res.status(200).json(newRoom);
});


module.exports = {setRooms};