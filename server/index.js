//packages
const express=require("express");
const mongoose=require("mongoose");
//import'package:Express/express.dart';

//init
const app=express();
const PORT=5000;
//const DB="mongodb+srv://fahadk8080:fahad0000@cluster0.h6981lh.mongodb.net/?retryWrites=true&w=majority";
const DB="mongodb+srv://fahadk8080:fahad0000@cluster0.h6981lh.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0";
//import from other files
const authRouter=require("./routes/auth");
const auth = require("./middlewares/auth");
const adminRouter=require('./routes/admin');
const productRouter = require("./routes/home");
const userRouter=require('./routes/user');

//middleware
app.use(express.json());
app.use(authRouter);
app.use(auth);
app.use(adminRouter);
app.use(productRouter);
app.use(userRouter);




//connection
mongoose.connect(DB, { useNewUrlParser: true, useUnifiedTopology: true }).then(()=>{
    console.log(`connected to db`)
});



app.get("/products",(req,res)=>{
    res.json({"vegetable":"ginger"});
});



//creating an api
app.get("/hello-world",(req,res)=>{
res.json({"hi":"Hello world"});
});
// get,put,post,delete,update = CRUD


app.listen(PORT,"0.0.0.0",()=>{
console.log(`Connected at ${PORT} hello`);
});