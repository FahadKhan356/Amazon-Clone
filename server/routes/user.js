// const  express=require('express');
// const Product = require('../models/product');
// const userRouter=express.Router();
// const User= require('../models/user');
// const auth=require('../middlewares/auth');


const express=require('express');
const userRouter=express.Router();
const auth=require('../middlewares/auth');
const User=require('../models/user');
const {Product}=require('../models/product');
const Order = require('../models/order');

userRouter.post('/api/add-to-cart',auth,async(req,res)=>{
    try{
        const{id}=req.body;
        let product=await Product.findById(id);
        let user=await User.findById(req.user);
     
        if(user.cart.length==0){
            user.cart.push({product,quantity:1});
        }else{
            let Productfound=false;
           for(let i=0;i<user.cart.length;i++){
            Productfound=user.cart[i].product._id.equals(product._id);
            
            }
            if(Productfound){
              let Producttt=user.cart.find((Productt)=>Productt.product._id.equals(product._id));
              Producttt.quantity+=1;

            }else{
                user.cart.push({product,quantity:1});

            }  
           }
          user=await user.save();
          res.json(user);

        }catch(e){
        res.status(500).json({error:e.message});
    }
});

userRouter.delete('/api/delete-from-cart/:id',auth,async(req,res)=>{
    try{
     const {id}=req.params;
     const product=await Product.findById(id);
     let user=await User.findById(req.user);

     for(let i=0;i<user.cart.length;i++){
        if(user.cart[i].product._id.equals(product._id))
        
        {
            if(user.cart[i].quantity==1){
                user.cart.splice(i,1);
            }else{
                user.cart[i].quantity-=1;
            }

        }
     }

     user=await user.save();
     res.json(user);


    }catch(error){
        res.status(500).json({error:error.message});
    }
});

userRouter.post('/api/address/save-address',auth,async(req,res)=>{
    try{
          const{address}=req.body; 
         let user=await User.findById(req.user);
         user.address=address;
         user=await user.save();
         res.json(user);

    }catch(error){
        res.status(500).json({ error: error.message});
    }
});


userRouter.post('/api/order-place',auth,async(req,res)=>{
    try{
        const{cart,address,totalprice}=req.body;
         let products=[];

         for(let i=0;i<cart.length;i++){
            let  product=await Product.findById(cart[i].product._id);
            console.log(product);
            if(product.quantity>=cart[i].quantity){
                product.quantity-=cart[i].quantity;
                products.push({product , quantity: cart[i].quantity});
                console.log(products);

                await product.save();
            }else{
                 res.json.status(400).json({ message: `${product.name} is out of stock!` });
            }
         }

  let user=await User.findById(req.user);
  user.cart=[];
  user=await user.save();

 let order=new Order({
    products:products,
    address,
    totalprice,
    UserID:req.user,
    orderedAt:new Date().getTime(),
  });

  order=await order.save();
  res.json(order);


    }catch(error){
        res.status(500).json({error:error.message});
    }
});


userRouter.get('/api/view-orders',auth,async(req,res)=>{
try{
let orders=await Order.find({UserID:req.user});
res.json(orders);


}catch(error){
    res.status(500).json({error:error.message});
}

});




module.exports=userRouter;











// userRouter.post('/api/add-to-cart',auth,async(req,res)=>{
//     try{
//     const {id}=req.body;
//     const product=await Product.findById(id);
//     const user=await User.findById(req.user);
    
//     if(user.cart.length==0){
//         User.cart.push({product,quantity:1});
//     }else{
//         let Productfound=false;
//         for(let i=0;i<user.cart.length;i++){
//             if(user.cart[i].product._id.equals(product._id)){
//                 Productfound=true;
//             }
//         }
    
//     if(Productfound){
//         const producttt=await user.cart.find((productt)=>productt.product._id.equals(product._id));
//        producttt.quantity+=1;
    
//     }else{
//         user.cart.push({product,quantity:1});
//         }
    
    
//     }
    
//     }catch(e){
//         res.status(500).json({error:e.message});
//     }
    
//     });

//     module.exports=userRouter;