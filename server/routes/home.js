
const express=require('express');
const productRouter=express.Router();
const auth=require('../middlewares/auth');
const {Product} = require('../models/product');


productRouter.get('/api/pro-categories',auth,async(req,res)=>{
try{
    console.log(req.query.category);
    const product=await Product.find({category:req.query.category});
    res.json(product);

}catch(e){
    res.status(500).json({error:e.message});
}

});

productRouter.get('/api/products/search/:name',auth,async(req,res)=>{
    try{
        console.log(req.params.name);
    const product=await Product.find({
        name: {$regex: req.params.name, $options:'i'}, });
    res.json(product);
    
    }catch(e){
        res.status(500).json({error:e.message});
    }
    
    
    
    });

   productRouter.post('/api/rate-product',auth,async(req,res)=>{
    try{
        const {id,rating}=req.body;
     let product=await Product.findById(id);
     for(let i=0;i<product.ratings.length;i++){
        if(product.ratings[i].userId==req.userId){
            product.ratings.splice(i,1);
            break;
        }
     }
    const ratingscheme={
        userId:req.userId,
        rating:rating,

    };
     product.ratings.push(ratingscheme);
     product=await product.save();
     res.json(product);
    
    }catch(e){
        res.status(500).json({error:e.message});
    }

   });


   productRouter.get('/api/fetch_deal-of-the-day',auth,async(req,res)=>{
    try{
     let product=await Product.find({});
     product=product.sort((a,b)=>{
     let Asum=0;
     let Bsum=0;

     for(let i=0; i<a.ratings.length; i++){
      Asum+=a.ratings[i].rating;

     }
     for(let i=0; i<b.ratings.length; i++){
        Bsum+=b.ratings[i].rating;
  
       }

       return Asum < Bsum ? 1: -1;
     });

  res.json(product[0]);
    }catch(e){
        res.status(500).json({error:e.message});
    }
   });











module.exports=productRouter;

