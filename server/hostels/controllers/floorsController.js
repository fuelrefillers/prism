const asyncHandler = require("express-async-handler");
const floorsModel = require("../models/floorsModel");

const setFloors = asyncHandler(async(req,res)=>{
    const floor = await floorsModel.create(res.body);
    res.status(200).json(floor);
});

const manageNoOfAvailableBeds = asyncHandler(async(req,res)=>{
    const floor = await floorsModel.findOne({type:req.type,floorNumber:req.floorNumber});
    floor.availableBeds = floor.availableBeds-1;
    await floor.save();
});



module.exports = {setFloors};