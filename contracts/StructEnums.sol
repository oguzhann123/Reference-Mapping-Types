// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

contract StructEnum{

    enum Status{
           Taken,
           Preparing,
           Boxed,
           Shipped  // 0,1,2,3
    }

struct Order{

address client;
string zipCode;
uint[] products;
Status status;
}

 Order[]public orders;
 address public  owner;
 constructor(){ owner=msg.sender;}

function createOrder(string memory _zipCode, uint[] memory _products) external returns(uint){

 require(_products.length > 0,"No products.");

 Order memory order;
 order.client = msg.sender;
 order.zipCode=_zipCode;
 order.products=_products;
 order.status=Status.Taken;
 orders.push(order);


// orders.push(
    
//     Order({

//     client:msg.sender,
//     zipCode:_zipCode,
//     products:_products,
//     status:Status.Taken
//     })
// );

// orders.push(Order(msg.sender,_zipCode,_products,Status.Taken));

 return orders.length-1;

}
function advanceOrder(uint _orderId) external  {

    require(owner==msg.sender, "u are not authorized");

    require(_orderId < orders.length,"not a valid order id.");
    Order storage order = orders[_orderId];
    require(order.status!=Status.Shipped,"order is already shipped");
    if(order.status==Status.Taken){
        order.status=Status.Preparing;
    }else if (order.status==Status.Preparing){
        order.status=Status.Boxed;
    }else if (order.status==Status.Boxed){
        order.status=Status.Shipped;
    }


}

function getOrder(uint _orderId) external  view returns(Order memory) {
    require(_orderId<orders.length," Not a valid order id.");
//Order memory order = orders[_orderId];
    return orders[_orderId];

}
function updateZip(uint _orderId, string memory _zip)   external  {

        require(_orderId<orders.length," Not a valid order id.");
        Order storage order = orders[_orderId];
        require(order.client==msg.sender,"u are not owner");
        order.zipCode=_zip;


}


}
  





