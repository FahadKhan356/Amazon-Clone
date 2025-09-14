const mongoose=require('mongoose');
const { productSchema } = require('./product');


const OrderSchema=mongoose.Schema({
products:[
    {
    product:productSchema,
    quantity:{
        type:Number,
        require:true,
    }
}
],
address:{
    type:String,
    require:true,
},
totalprice:{
    type:Number,
    require:true,
},
UserID:{
    type:String,
    require:true,
},
orderedAt:{
    type:String,
    require:true,
},
status:{
    type:Number,
    default:0,
}


});

const Order=mongoose.model('order',OrderSchema);
module.exports=Order;