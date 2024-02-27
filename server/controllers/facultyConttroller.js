const asyncHandler = require("express-async-handler");
const Faculty = require("../models/facultyModel");
const jwt=require("jsonwebtoken");
const timeTablesModel = require("../models/TTM");
const facultyTimeTableModel = require("../models/facultyTimeTableModel");



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

const getFacultyByDepartment = asyncHandler(async(req,res)=>{

    let filter = {};
    if(req.query){ 
        filter = {FacultyDepartment:req.query.facultyDepartment};
    }
    const faculties = await Faculty.find(filter);
    res.json(faculties);
});




async function assignDataToFaculty() {
    const AllFaculty = await Faculty.find();

    for(const faculty of AllFaculty){
        for(const classes of faculty.Classes){
            // console.log(classes.Department);
            const CurrentClassTimeTable = await timeTablesModel.findOne({"Department.name":classes.Department,"Regulation.title":classes.Regulation,"Section.Name":classes.Section});


            if(CurrentClassTimeTable){
                const transformedTimetable = CurrentClassTimeTable.Section.TimeTable.map((week) => {
                    return {
                        Day: week.Day,
                        Periods: week.Periods.filter(period => {
                            const lecturers = period.LecturerId.split(",");
                            return lecturers.includes(faculty.FacultyId);
                        }).map(period => ({
                            StartTime: period.StartTime,
                            EndTime: period.EndTime,
                            ClassType: period.ClassType,
                            Section:classes.Section,
                            Department:classes.Department,
                            Year:classes.Year,
                            regulation:classes.Regulation,
                            SubjectName: period.SubjectName,
                            Subjectcode: period.Subjectcode,
                        }))
                    };
                });
    
                const existingFacultyTimeTable = await facultyTimeTableModel.findOne({
                    FacultyId: faculty.FacultyId,
                  });
            
                if (existingFacultyTimeTable) {
                const existingPeriods = existingFacultyTimeTable.TimeTable.reduce((existing, week) => {
                    existing[week.Day] = existing[week.Day] || [];
                    existing[week.Day].push(...week.Periods);
                    return existing;
                    }, {});
            
                    const newPeriods = transformedTimetable.reduce((newPeriods, week) => {
                    newPeriods[week.Day] = newPeriods[week.Day] || [];
                    newPeriods[week.Day].push(...week.Periods);
                    return newPeriods;
                    }, {});
            
                    const updatedTimetable = Object.entries(existingPeriods).map(([day, periods]) => {
                    const combinedPeriods = [...periods, ...newPeriods[day] || []];
                    const uniquePeriods = [...new Set(combinedPeriods)];
                    return { Day: day, Periods: uniquePeriods };
                    });
            
    
                    existingFacultyTimeTable.TimeTable = updatedTimetable;
                    await existingFacultyTimeTable.save();
                    console.log(`Updated timetable for Faculty ${existingFacultyTimeTable._id}`);
                } else {
                const FacultyTimeTable = await facultyTimeTableModel.create({
                    FacultyId: faculty.FacultyId,
                    FacultyName: faculty.FacultyName,
                    FacultyDepartment:faculty.FacultyDepartment,
                    TimeTable: transformedTimetable,
                });
                console.log(`Created new timetable for Faculty ${FacultyTimeTable._id}`);
                }
            }



        }
    }
    
    
    // const timetableObject = transformedTimetable.reduce((timetable, day) => {
    //     timetable[day.Day] = day.Periods;
    //     return timetable;
    // }, {});
    
    // console.log(transformedTimetable);
}

  
// assignDataToFaculty();


module.exports = {createFaculty,loginFaculty,getFacultyData,getFacultyByDepartment};