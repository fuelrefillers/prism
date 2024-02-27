const asyncHandler = require("express-async-handler");
const facultyTimeTableModel = require("../models/facultyTimeTableModel");
const Faculty = require("../models/facultyModel");
const AttendanceHistory = require("../models/attendanceHistory");



const AssignSubstitute = asyncHandler(async(req,res)=>{
    let filter = {};
    if(req.query){ 
        filter = {FacultyDepartment:req.query.facultyDepartment,Day:req.query.day,StartTime:req.query.starttime,EndTime:req.query.endtime};
    }
    const facultyTimetables = await facultyTimeTableModel.find({FacultyDepartment:filter.FacultyDepartment});


    const kaliFellows = []
    for(const timetable of facultyTimetables){
      const dayTimetables = [];
      dayTimetables.push(timetable.TimeTable.find(day => day.Day === filter.Day));
      for(const s of dayTimetables){
        let foundElement = s.Periods.find(p => (p.StartTime === filter.StartTime && p.EndTime === filter.EndTime));

        // for(const p of s.Periods){
        //   console.log(new Date('2024-02-19 ' + p.StartTime).toLocaleTimeString('en-US', { hour: '2-digit', minute: '2-digit' }),
        //   new Date('2024-02-19 ' + p.EndTime).toLocaleTimeString('en-US', { hour: '2-digit', minute: '2-digit' }));
        // }
        if (foundElement === undefined) {
          kaliFellows.push({
            FacultyId:timetable.FacultyId,
            FacultyName:timetable.FacultyName
          })
        }
      }
    }


    // let kaliGaUnnollu = [];
    //   for (const faculty of facultiesWithNoPeriods) {
    //     kaliGaUnnollu.push({
    //         FacultyName:`${faculty.FacultyName}`,
    //         FacultyID:`${faculty.FacultyId}`
    //     });
    //   }

  res.json(kaliFellows);
});



const settingSubstitute = asyncHandler(async(req,res)=>{
    const {facultyId,facultyName,startTime,endTime,date,day,department,section,regulation,year} = req.body;
    const faculty = await Faculty.findOne({FacultyId:facultyId,FacultyName:facultyName});
    const ff = {
      StartTime:startTime,
      EndTime:endTime,
      Date:date,
      Day:day,
      Department:department,
      Section:section,
      Regulation:regulation,
      Year:year
    }
    let dummy = faculty.SubstitueInfo;
    dummy.push(ff);

    faculty.SubstitueInfo = dummy;

    // await faculty.save();

    const ggg = await AttendanceHistory.find({Regulation:regulation,Department:department,Section:section});
// console.log(ggg);
    for(const doc of ggg){
            const timetableToUpdate = doc.TimeTable.find(timetable => timetable.date === date);
            // console.log(timetableToUpdate.Periods);
            const pp = timetableToUpdate.Periods.find(entry => entry.StartTime === startTime );
            pp.Substitute = true;
            pp.SubstituteId = facultyId;
            pp.SubstituteName = facultyName

            await doc.save();
    }






    res.json(faculty);
});

// settingSubstitute();

module.exports = {AssignSubstitute,settingSubstitute};