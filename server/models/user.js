const mongoose=require("mongoose");
const {productSchema}=require('./product');

const userschema=mongoose.Schema({
    name:{
        require:true,
        type:String,
        trim:true,
    },
    email:{
        require:true,
        type:String,
        trim:true,
        validate:{
            validator:(value)=>{
             const   re= /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
             return value.match(re);  
            
            },
         message:"please enter a valid email address",
        },
    },
    password:{
        require:true,
        type:String,
        
    },
    address:{
        default:"",
        type:String,
    },
    type:{
        type:String,
        default:"User",
    },
   //cart
   cart:[
    {
       product:productSchema,
       quantity:{
        type:Number,
        require:true,
       }
    }
    
   ]

});

const User=mongoose.model("User",userschema);
module.exports=User;