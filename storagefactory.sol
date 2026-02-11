// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;
// import "./SimpleStorage.sol";
import {SimpleStorage} from "./SimpleStorage.sol";
contract storagaefactory{
    //SimpleStorage public mysimplestorage;
   SimpleStorage[] public listofsimplestoragecontracts;
  // address[] public listofsimplestorageAddresses;
     function createsimplestoragefactory() public{
        // how does the storage factory knows that simple storage looks like?
       // mysimplestorage=new SimpleStorage();
       SimpleStorage newSimpleStoragecontract = new SimpleStorage();
       listofsimplestoragecontracts.push(newSimpleStoragecontract);
     }
       function sfStore(uint256 _simpleStorageindex, uint256 _newsimpleStorageNumber) public {
        // address and ABI(application binary interface) is needed to iteract with the function
       
       SimpleStorage mysimplestorage=listofsimplestoragecontracts[_simpleStorageindex];
       mysimplestorage.store(_newsimpleStorageNumber);
       }
       function sfget(uint256 _simplestorageindex) public view returns (uint256) {
        SimpleStorage mysimplestorage = listofsimplestoragecontracts[_simplestorageindex];
        return mysimplestorage.retrieve();
       }
}  