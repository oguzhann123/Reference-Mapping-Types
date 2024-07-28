// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;


contract WillThrow{
            error NotAllowedError(string);

    function aFuction() public pure {
        //require(false,"Error Message.");
       // assert(false);
       revert NotAllowedError(" you are not allowed");
    }
 
}
contract ErrorHandling {
   event ErrorLogging(string reason);
   event ErrorLogCode(uint errorCode);
   event ErrorLogBytes(bytes lowLevelData);

  function catchTheError() public {
        
        WillThrow will = new WillThrow();
     //   will.aFuction();
     try will.aFuction(){
        // add code here if it works
     }catch Error(string memory reason){
        emit ErrorLogging(reason);

     } catch Panic(uint errorCode){
          emit ErrorLogCode(errorCode);
     }catch (bytes memory lowLevelData){
      emit ErrorLogBytes(lowLevelData);
     }
        
    }
}