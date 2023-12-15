const asyncHandler = require("express-async-handler");
const Faculty = require("../models/facultyModel");
const jwt=require("jsonwebtoken");

const createFaculty = asyncHandler(async(req,res)=>{
    const user = await Faculty.create(req.body);
    res.status(200).json(user);
});


const loginFaculty = asyncHandler(async (req,res) =>{
    const {UserName,Password} = req.body;
    if(!UserName || !Password){
        res.status(400).json({error:"all fields are manditory"});
    }
    const user = await Faculty.findOne({UserName});    
    if(user && (user.Password===Password)){
            const accessToken = jwt.sign(
                {
                    user : {
                        id : user.FacultyId,
                    }
                },
                process.env.ACCESS_TOKEN_SECERT,
            );
            res.json({token:accessToken});
    }else{
        res.status(400).json({error:"user not found or roolno or password dont match"});
    }
    
});

const getFacultyData = asyncHandler(async(req,res)=>{
    const currentUser = await Faculty.findOne({ FacultyId: req.user.id} );
    res.json(currentUser);
});


module.exports = {createFaculty,loginFaculty,getFacultyData};