// SPDX-License-Identifier: MIT
pragma solidity 0.8.16;

contract Consumer{
    function getBalance() public view returns(uint){
        return address(this).balance;
    }
    function deposite()public payable {}
}

contract SmartContractWallet{
        address payable public  owner;        // wallet has 1 owner 

    mapping (address=>uint) public allowance;
    mapping (address=>bool) public isAllowancedToSend;
    mapping  (address=>bool) public guardians;
    address payable  nextOwner;
    mapping (address=>mapping (address=>bool)) public nextOwnerGuardianDidNot;
    uint guardiansResetCount;
    uint public constant confirmationFromGuardiansForReset=3;

    constructor(){     
        owner = payable(msg.sender);
    }

    function setGuardian(address _guardian, bool _isGuardian) public {
        require(msg.sender==owner,"you are not the owner, aborting");
        guardians[_guardian]=_isGuardian;

    }
    function proposeNewOnwer(address payable _newOwner)public {
        require(guardians[msg.sender],"you are not gurdian of this wallet,aborting");
        require(nextOwnerGuardianDidNot[_newOwner][msg.sender]==false,"you already voted, aborting");
        if(_newOwner!=nextOwner){
            nextOwner=_newOwner;
            guardiansResetCount=0;
        }
        guardiansResetCount++;
        if(guardiansResetCount>= confirmationFromGuardiansForReset){
            owner = nextOwner;
            nextOwner = payable (address(0));
        }
    }

function setAllowance(address _for, uint _amount) public {
    require(msg.sender==owner,"you are not owner, aborting");
    allowance[_for]=_amount;
 if (_amount>0){
    isAllowancedToSend[_for]=true;
 }else{
    isAllowancedToSend[_for]=false;
 }
}


function transfer(address payable _to, uint _amount, bytes memory _payload) public  returns (bytes memory) {
  //  require(msg.sender==owner,"You are not owner, aborting.");
  if(msg.sender!=owner){
    require(isAllowancedToSend[msg.sender],"Your are not allowed to send anything from this smart contract, aborting");
    require(allowance[msg.sender]>=_amount,"You are trying to send more than you are allowted to, aborting");
    allowance[msg.sender]-=_amount;
  }

 ( bool success, bytes memory returnData) = _to.call{value: _amount}(_payload);
 require(success,"Aborting, call was not succesful");
 return returnData;


}


    receive() external payable { }  // receive funds with a fallback function
}


