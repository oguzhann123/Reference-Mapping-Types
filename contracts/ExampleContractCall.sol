// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

contract Contractone{

mapping (address=>uint) public addressBalance;


function deposit() public payable {

    addressBalance[msg.sender]+=msg.value;
}
receive() external payable { deposit(); }


}
contract Contracttwo{

receive() external payable { }


function depositOnContractonOne(address _contractOne) public{

    bytes memory payload = abi.encodeWithSignature("deposit()");
   (bool success,)= _contractOne.call{value:10,gas:100000}(payload);
   require(success);
}



}