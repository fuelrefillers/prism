const express = require("express")
const asynchandler = require("express-async-handler")
const timeTablesModel = require("../models/TTM")

const setTimeTable = asynchandler(async(req,res)=>{
    const Data = await timeTablesModel.create(req.body);
    res.json(Data);
});

module.exports = {setTimeTable}; 