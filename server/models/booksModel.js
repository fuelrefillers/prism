const mongoose = require("mongoose");

const booksSchema = mongoose.Schema({
    BookName:{
        type:String,
        required:true,
    },
    BookImageUrl:{
        type:String,
        required:true,
    },
    BookLinkUrl:{
        type:String,
        required:true,
    },
    BookAuthor:{
        type:String,
        required:true,
    },
    Semester:{
        type:String,
        required:true,
    },
    Department:{
        type:String,
        required:true,
    }

});

module.exports = mongoose.model("Book",booksSchema);