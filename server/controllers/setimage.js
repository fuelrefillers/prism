const express = require("express");
const multer = require("multer");
const path = require("path");
const router = express.Router();
const Book = require("../models/booksModel");
const asynchandler = require("express-async-handler");

const storage = multer.diskStorage({
     destination: (req, file, cb) => {
        if (file.fieldname === "booksCover") {
            cb(null, './upload/booksCover/')
        }
        else if (file.fieldname === "booksPdf") {
            cb(null, './upload/booksPdf/');
        }
     },
    filename: (req, file, cb) => {

        if (file.fieldname === "booksCover") {
            return cb(null, `BOOKSCOVER${file.fieldname}_${Date.now()}${path.extname(file.originalname)}`)

        }
        else if (file.fieldname === "booksPdf") {
            return cb(null, `PDF${file.fieldname}_${Date.now()}${path.extname(file.originalname)}`)
        }
    }
})

const upload = multer({storage: storage,});

router.post("/upload", upload.fields([{name:'booksCover',maxCount:1},{name:'booksPdf',maxCount:1}]), asynchandler(async(req, res) => {

    console.log("hii");
    const {bookname,department,semester}=req.body;

    const file1 = req.files['booksCover'][0].filename;
    const file2 = req.files['booksPdf'][0].filename;

    const book = await Book.create({BookName:bookname,Department:department,Semester:semester,BookImageUrl:`http://localhost:3000/upload/booksCover/${file1}`,BookLinkUrl:`http://localhost:3000/upload/booksPdf/${file2}`,BookAuthor:"sai"});

    res.send(200).json(book);
}));

module.exports = router;