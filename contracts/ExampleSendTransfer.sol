// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;


contract ExampleSendTransfer{

   receive() external payable { }

   function withdrawTrasnfer(address payable _to)public{
    _to.transfer(10);
   }


   function withdrawSend(address payable _to) public {
         bool iSent = _to.send(10);
         require(iSent,"sending the funds was unsuccesful");
   }

}
contract ReceiverNoAction{

    function balance() public view returns(uint){
        return address(this).balance;
    }

    receive() external payable { }
}
contract ReceiverAction{
uint public balanceReceived;

receive() external payable { 
    balanceReceived+=msg.value;
}
 function balance() public view returns(uint){
        return address(this).balance;
    }


}