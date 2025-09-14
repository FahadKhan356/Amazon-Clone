const mongoose=require('mongoose');

const ratingscheme=mongoose.Schema({

    userId:
    {  type:String,
       require:true,

    },
    rating:{
        type:Number,
        required:true,
    },



});
module.exports=ratingscheme;