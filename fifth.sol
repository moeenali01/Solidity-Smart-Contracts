//SPDX-License-Identifier: MIT

pragma solidity ^0.8.14;

contract MappingsStructExample{
    mapping(address=>uint) public Data;
    uint id=1;
    function first(address _addr) public {
         Data[_addr]=id;
        id++;
    }

    function deleteaddress(address _addr) public{
        delete Data[_addr];
    }
}

    