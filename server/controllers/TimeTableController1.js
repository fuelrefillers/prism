const express = require("express")
const asynchandler = require("express-async-handler")
const timeTablesModel = require("../models/TTM")
// const excelToJson = require('excel-to-json');
const ExcelJS = require("exceljs");
const path = require("path");
var XLSX = require("xlsx");
const TimeTableModel = require("../models/TTM"); 




const setTimeTable = asynchandler(async(req,res)=>{
    const Data = await timeTablesModel.create(req.body);
    res.json(Data); 
});

const convertTimeTable = asynchandler(async(req,res,f)=>{
    let days = [];
    let tttt = [];
    var workbook = XLSX.readFile(f);
    let worksheet = workbook.Sheets[workbook. SheetNames [0]];


    for (let col = 1; col < 10; col++) {
        const cell = worksheet[XLSX.utils.encode_col(col) + 8];
        const acell = worksheet[XLSX.utils.encode_col(col) + 9];

        if (cell) {
            if (cell.t === 's' && cell.v.match(/^[IVX]+$/)) {
                tttt.push(acell.v);
        } else {
            console.log("Cell is undefined or empty.");
        }
        }
    }


    let periodswhole = [];
    for(let i=10;i<=15;i++){
        let periods = [];
        const c = worksheet[XLSX.utils.encode_col(0) + i];
        days.push(c.v);
        for(let col=1 ; col<=10 ; col++){
            const cell = worksheet[XLSX.utils.encode_col(col) + i];
                if (cell && (cell.v !== "BREAK") && (cell.v !== "LUNCH" )) {
                    let period = cell.v;
                    let intermediate = cell.v.split(" ");

                    if(intermediate.includes("LAB")){
                        col += 3;
                        periods.push(cell.v)
                    }else{
                        periods.push(cell.v)
                    }
                }
        }
        periodswhole.push(periods);
    }



    let startandendarr = [];
    for (let row = 0; row < periodswhole.length; row++) {
        let temp = [];
        let ss=0;
        for (let col = 0; col < periodswhole[row].length; col++) {
            let intermediate = periodswhole[row][col].split(" ");
            if(intermediate.includes("LAB")){
                let t1 = tttt[ss].split("-")[0];
                let t2 = tttt[ss+2].split("-")[1];
                let combinedStr = t1+"-"+t2;
                temp.push(combinedStr);
                ss +=2;
            }
            else{
                temp.push(tttt[ss]);
                ss +=1;
            }
        }
        startandendarr.push(temp);
    }




    const workbook1 = new ExcelJS.Workbook();
    await workbook1.xlsx.readFile("upload/timetable/TIMETABLE-TEST.xlsx");
    const worksheet1 = workbook1.getWorksheet(1); // Assuming the first worksheet

    let foundCell;

    worksheet1.eachRow({ includeEmpty: false }, (row, rowNumber) => {
        row.eachCell({ includeEmpty: false }, (cell, colNumber) => {
            if (cell.value === "Total") {
                foundCell = cell;
                return false; // break out of the loop
            }
        });
        if (foundCell) return false; // break out of the loop
    });


    let total = 0;
    if (foundCell) {
        let a = parseInt(foundCell.address.substring(1,3));
        total = worksheet[XLSX.utils.encode_col(4) + a].v;
    } else {
        console.log("String not found in the worksheet.");
    }


    // console.log(total);

    let facultyDetails = [];
    let countTotal = 0;
    let currrow = 18;
    while(countTotal < total){

            let sirmadam ={
                ClassName : worksheet[XLSX.utils.encode_col(3) + currrow]?.v ?? "Blank",
                SubjectName:worksheet[XLSX.utils.encode_col(1) + currrow]?.v ?? "Blank",
                Subjectcode:worksheet[XLSX.utils.encode_col(0) + currrow]?.v ?? "Blank",
                LecturerName:worksheet[XLSX.utils.encode_col(5) + currrow]?.v ?? "Blank",
                LecturerId:worksheet[XLSX.utils.encode_col(9) + currrow]?.v ?? "Blank", 
                LecturerNumber:worksheet[XLSX.utils.encode_col(8) + currrow]?.v ?? "Blank"
            }
        currrow +=1;
        countTotal += worksheet[XLSX.utils.encode_col(4) + currrow].v;
            facultyDetails.push(sirmadam);
    }

    // console.log(facultyDetails);



    let TimeTable = [];
    for(let i=0;i<days.length;i++){
        let sai={
            Day:days[i],
            Periods : []
        }
        for(let j=0;j<startandendarr[i].length;j++){
            intermediate = periodswhole[i][j].split(" ");

            if(intermediate.includes("LAB")){
                let searchKey = intermediate[0].split("/")[0]+" LAB";
                // console.log(searchKey);
                let ansobj = facultyDetails.find(entry => entry.ClassName === searchKey);
                // console.log(ansobj);
                sai.Periods.push({
                StartTime : startandendarr[i][j].split("-")[0],
                EndTime : startandendarr[i][j].split("-")[1],
                ClassName : searchKey,
                ClassType : "Lab",
                SubjectName : ansobj.SubjectName,
                Subjectcode : ansobj.Subjectcode,
                LecturerName : ansobj.LecturerName,
                LecturerId : ansobj.LecturerId,
                LecturerNumber : ansobj.LecturerNumber
                });
            }
            else{
                let ansobj = facultyDetails.find(entry => entry.ClassName === (periodswhole[i][j]).split("_")[0]);
                sai.Periods.push({
                StartTime : startandendarr[i][j].split("-")[0],
                EndTime : startandendarr[i][j].split("-")[1],
                ClassName : periodswhole[i][j],
                ClassType : "Lecture",
                SubjectName : ansobj.SubjectName,
                Subjectcode : ansobj.Subjectcode,
                LecturerName : ansobj.LecturerName,
                LecturerId : ansobj.LecturerId,
                LecturerNumber : ansobj.LecturerNumber
                });
            }
        }
        TimeTable.push(sai);
        // console.log(sai);
    }



    const {timetablename,department,regulation,section}=req.body;

    const creatingTimeTable = await TimeTableModel.create({Regulation:{title:regulation},Department:{name:department},Section:{Name:section,TimeTable : TimeTable}});

    console.log("Rojer reporting from big code its workingggggg !!!!! Fuck it");
});
// convertTimeTable();
module.exports = {setTimeTable,convertTimeTable};