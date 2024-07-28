// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

contract ExampleMapping{

mapping (address => bool) public registered;
mapping (address => uint) public  favNums;

function Register(uint _favNums) public {
    require(!isRegistered(),"User is already registered ");
    registered[msg.sender]=true;
    favNums[msg.sender]=_favNums;
    
}

function isRegistered() public view returns(bool){
      return registered[msg.sender];
}

function deleteRegistered() public {

    require(isRegistered(), "User is not Registered");
    delete(registered[msg.sender]);
    delete (favNums[msg.sender]);
}


}


contract NestedMapping{
    mapping(address => mapping (address=>uint)) public debts;
    

    function incDebt(address _borrower, uint _amount) public {
        debts[msg.sender][_borrower]+=_amount;
    }
    function decDebt(address _borrower, uint _amount) public {
        debts[msg.sender][_borrower]-=_amount;
    }
    function getDebt(address _borrower) public view returns(uint){
       return  debts[msg.sender][_borrower];
    }
}

