const express=require("express");
const User=require("../models/user");
const bcrypt=require("bcryptjs");
const jwt=require("jsonwebtoken");
const auth=require("../middlewares/auth");



const authRouter=express.Router();

authRouter.get("/user",(req,res)=>{
    res.json({"name":"fahad"});
});

//made authRouter global now everywhere it can be used
module.exports=authRouter;

//post the data to database
authRouter.post("/api/signup",async(req,res)=>{
  try{
    const {name, email, password} =req.body;
  

    //logic for if email already exists  
    const Existinguser=await User.findOne({email});
       if(Existinguser){
        return res.status(400).json({msg:"email already exists"});
       }
 const hashedpassword=await bcrypt.hash(password,8);

       let user=new User({
        email,
        password:hashedpassword,
        name,
       });
       user=await user.save();
       res.json(user);

  }catch(e){res.status(500).json({error:e.message});
}
  
});

//signin api

authRouter.post("/api/signin",async(req,res)=>{
try{
  const {email,password}=req.body;

 const user1=await User.findOne({email});
 if(!user1){
  return res.status(400).json({msg:"email does not exists"});
 }
const ismatch=await bcrypt.compare(password,user1.password);
if(!ismatch){
 return res.status(400).json({msg:"incorrect password!"})
}
const token=jwt.sign({id:user1._id},"passwordKey");
 res.json({token, ...user1._doc});

}catch(e){
  console.error("error");
  res.status(500).json({error:e.message});
}


authRouter.post("/validtoken",async(req,res)=>{
  try{
  const token= req.header('x-auth-token');
 
  if(!token) return res.json(false);

  const verified=jwt.verify(token,"passwordKey");
  if(!verified) return res.json(false);

  const user=await User.findById(verified.id);
  if(!user)return res.json(false);

  res.json(true);
  }catch(e){
    res.status(500).json({error:e.message});
  }   
});

authRouter.get("/",auth,   async(req,res)=>{
const user=await User.findById(req.user);
res.json({ ...user._doc, token: req.token});
})





});
