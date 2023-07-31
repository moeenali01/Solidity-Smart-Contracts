// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract wallet{
    struct transaction{
        uint amount;
        uint timestamp;
    }
    struct data{
        uint balance;
        uint numdeposits;
        mapping(uint=>transaction) deposit;
        uint numwithdrawl;
        mapping(uint=>transaction) withdrawl;
    }
    mapping(address=>data) public  all;
    function send() public payable {
        all[msg.sender].balance+=msg.value;
        transaction memory t1;
        t1.amount=msg.value;
        t1.timestamp=block.timestamp;
        all[msg.sender].deposit[all[msg.sender].numdeposits]=t1;
        all[msg.sender].numdeposits++;
    }
    
    function cashout(uint _amount) public {
        all[msg.sender].balance-=_amount;
         transaction memory val2= transaction(_amount,block.timestamp);
        all[msg.sender].withdrawl[all[msg.sender].numwithdrawl]=val2;
        all[msg.sender].numwithdrawl++;
    }
    function getdepositdata(uint id, address add) public view  returns(transaction memory){
        return all[add].deposit[id];
    }
    function getwithdrawdata(uint id,address addr) public view returns(transaction memory){
        return all[addr].withdrawl[id];
    }
    function checkbalance() public view returns(uint){
        return address(this).balance;
    }
}
