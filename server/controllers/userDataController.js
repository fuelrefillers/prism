const asyncHandler = require("express-async-handler");
const UserData = require("../models/userDetailsModel");
const jwt=require("jsonwebtoken");

const getUserData = asyncHandler(async(req,res)=>{
    const currentUser = await UserData.findOne({RollNo : req.user.roolno});
    res.json(currentUser);
});

const getallUserData = asyncHandler(async(req,res)=>{
    const currentUser = await UserData.find();
    res.json(currentUser);
});

const getAllUsersDataAsSection = asyncHandler(async(req,res)=>{
    
    let filter = {};
    if(req.query){ 
        const rollNoRegExp = new RegExp(`^${req.query.regulation}`);
        filter = {Section:req.query.section,Department:req.query.department,RollNo:rollNoRegExp};
    }

    const currentUsers = await UserData.find(filter,{'RollNo':1,'StudentName':1,'_id':0});
    console.log(filter);
    res.json(currentUsers);

});

const createUserData = asyncHandler(async(req,res)=>{
    //const {rollno,imageurl,name,branch,clas,studentphno,studentemail,parentname,parentphno,parentemail} = req.body;
    const newUserDetails =await UserData.create(req.body);
    res.status(200).json(newUserDetails);
});

const deleteUserData = asyncHandler(async(req,res)=>{
    const deletedUser = await UserData.findByIdAndRemove(req.params.id);
    res.status(200).json({dUser:deletedUser,message:"succes"});
});

const deleteAllUsersData = asyncHandler(async(req,res)=>{
    await UserData.deleteMany();
    res.status(200).json({message:"success"});
});

const validateUser = asyncHandler(async(req,res)=>{
    res.json(req.user);
});


const loginUser = asyncHandler(async (req,res) =>{
    const {UserName,Password} = req.body;
    if(!UserName || !Password){
        res.status(400).json({error:"all fields are manditory"});
    }
    const user = await UserData.findOne({UserName});    
    if(user && (user.Password===Password)){
            const accessToken = jwt.sign(
                {
                    user : {
                        id : user.id,
                        roolno :user.RollNo,
                    }
                },
                process.env.ACCESS_TOKEN_SECERT,
            );
            res.json({token:accessToken});
    }else{
        res.status(400).json({error:"user not found or roolno or password dont match"});
    }
    
});

module.exports = {getUserData,createUserData,deleteAllUsersData,deleteUserData,getallUserData,validateUser,getAllUsersDataAsSection,loginUser};