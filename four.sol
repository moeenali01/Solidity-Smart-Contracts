// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract example{
    mapping(address=>uint) public data;
    function SetData() public{
        data[msg.sender]=123;
        //uint bal= data[msg.sender];
    }
}