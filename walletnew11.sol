// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;
contract wallet{
struct transection{
    uint amount;
    uint time;
}
struct data{
    uint balance;
    uint depositid;
    mapping(uint=>transection) depositdata;
    uint withdrawid;
    mapping(uint=>transection) withdrawdata;
}
mapping(address=>data) public Transaction_data;

function Send_Money() public payable {
    Transaction_data[msg.sender].balance+=msg.value;
    transection memory t1;
    t1.amount=msg.value;
    t1.time=block.timestamp;
    Transaction_data[msg.sender].depositdata[Transaction_data[msg.sender].depositid]=t1;
    Transaction_data[msg.sender].depositid++;

    }

    function Withdraw(uint _amount) public {
        Transaction_data[msg.sender].balance-=_amount;
        transection memory t2;
        t2.amount=_amount;
        t2.time=block.timestamp;
        Transaction_data[msg.sender].withdrawdata[Transaction_data[msg.sender].withdrawid]=t2;
        Transaction_data[msg.sender].withdrawid++;
    }

    function Get_Deposit_Data(uint id, address addr) public view returns(transection memory){
        return Transaction_data[addr].depositdata[id];
    }

    function Withdraw_Data(uint id,address addr) public view returns(transection memory){
        return Transaction_data[addr].withdrawdata[id];
    }



}