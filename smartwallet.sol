// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract smartwallet{
    struct transaction{
        uint _amount;
        uint timestamp;
    }
    struct balance{
        uint total_balance;
        uint num_deposits;
        mapping (uint=>transaction) deposits;
        uint num_withdrawl;
        mapping (uint=>transaction) withdrawl;
    }

    mapping (address=>balance) public balances;

    function deposit_money() public payable {
        balances[msg.sender].total_balance+=msg.value;
        transaction memory depost= transaction(msg.value, block.timestamp);
        balances[msg.sender].deposits[balances[msg.sender].num_deposits]= depost;
        balances[msg.sender].num_deposits++;

    }

    function withdrawl(uint _amount, address payable  _to) public payable{
        balances[msg.sender].total_balance-=_amount;
        transaction memory withdrawls= transaction(_amount, block.timestamp);
        balances[msg.sender].withdrawl[balances[msg.sender].num_withdrawl]= withdrawls;
        _to.transfer(_amount);
        balances[msg.sender].num_withdrawl++;
    }


    function Deposit_Details(address _from , uint num) public view returns (transaction memory){
        return balances[_from].deposits[num];
    }

    function withdrawl_details( address _to, uint num) public view returns(transaction memory){
        return balances[_to].withdrawl[num];
    }
}