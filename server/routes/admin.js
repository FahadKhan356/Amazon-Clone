const express=require('express');
const adminRouter=express.Router();
const {Product}=require('../models/product');
const admin=require('../middlewares/admin');
const Order=require('../models/order');

adminRouter.post('/admin/add-products',admin,async(req,res)=>{
try{
    const {name,description,quantity,images,category,price}=req.body;
  let product=new Product({
           name,
           description,
           quantity,
           images,
           category,
           price,
});
  product=await product.save();
  res.json(product);

}catch(e){
     res.status(500).json({error:e.message});
}

    
});

//to get products document

adminRouter.get('/admin/get-products',async(req,res)=>{
try{
  const product=await Product.find({});

res.json(product);
}catch(e)
{
  res.status(500).json({error:e.message});
}
});


adminRouter.post('/admin/delete-products',admin,async(req,res)=>{
try{
  const {id}=req.body;
if(!id)
res.status(400).json({message:'Product Id Required!'});

  let product=await Product.findByIdAndDelete(id);
res.json(product);

}catch(e){
res.status(500).json({error:e.message});
}

});
adminRouter.get('/admin/get-orders',admin,async(req,res)=>{
  try{
  const order=await Order.find({});
 res.json(order);
  }catch(error){
    res.status(500).json({error:error.message});
  }
});


adminRouter.post('/admin/changeOrderStatus',admin,async(req,res)=>{
  const{id,status}=req.body;
  try{
     let order=await Order.findById(id);
     order.status=status;
     order=await order.save();
     res.json(order);
  
  }catch(error){
   res.status(500).json({error:error.message})
  }
});


adminRouter.get("/admin/analytics",admin,async(req,res)=>{
  try{

    let totalearnings=0;
    let order=await Order.find({});

    for(let i=0;i<order.length; i++){
      for(let j=0;j<order[i].products.length;j++){

        totalearnings+= order[i].products[j].quantity * order[i].products[j].product.price;
      }
    }

   let MobilesEarnings=await fetchCategoryWiseProduct('Mobiles');
   let EssentialsEarnings=await fetchCategoryWiseProduct('Essentials');
   let AppliancesEarnings=await fetchCategoryWiseProduct('Appliances');
   let BooksEarnings=await fetchCategoryWiseProduct('Books');
   let FashionEarnings=await fetchCategoryWiseProduct('Fashion');

   let earnings={
    totalearnings,
    MobilesEarnings,
    EssentialsEarnings,
    AppliancesEarnings,
    BooksEarnings,
    FashionEarnings,
   }

   res.json(earnings);

  }catch(error){
    res.status(500).json({error:error.message});
  }
});

async function fetchCategoryWiseProduct(category){

  let earnings=0;
  let categoryOrder=await Order.find({'products.product.category':category});

  for(let i=0;i<categoryOrder.length;i++){
    for(let j=0; j<categoryOrder[i].products.length;j++){
      earnings+=categoryOrder[i].products[j].quantity * categoryOrder[i].products[j].product.price;
    }
  }

return earnings;
}


module.exports=adminRouter;
