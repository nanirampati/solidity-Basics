// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
contract simplestorage{
    uint256 myfavoritenumber;
    uint256[] listoffavoritenumbers;
    struct person{
        uint256 favoritenumber;
        string name;
    }
    mapping(string =>uint256) public nameToFavoritenumber;
    // person public person1=person({favoritenumber:70,name:"pat"});
    // person public person2=person({favoritenumber:23,name:"nani"});
    // person public person3=person({favoritenumber:22,name:"err"});
    person[] public listofpeople;
    function store(uint256 _favoritenumber)public virtual{
        myfavoritenumber=_favoritenumber;
    }
    function addperson(string calldata _name, uint256  _favoritenumber) public{
        //calldata,memory
        // arrays can built with the function called push which allows us to add elements in the array
        // person memory newperson=person(_favoritenumber,_name);
        // listofpeople.push(newperson); this is one type of aarray
        listofpeople.push(person(_favoritenumber,_name));
        nameToFavoritenumber[_name]=_favoritenumber;
    }
    function retrieve()public view returns(uint256){
        return myfavoritenumber;
    }

 }