// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;
contract wal{
    struct transection{
        uint amount;
        uint timestamp;
    }
    struct data{
        uint totalbalance;
        uint numdeposits;
        mapping (uint=>transection) deposits;
        uint numcashout;
        mapping (uint=>transection) withdrawls;
        mapping(uint=>transection) receiver;
        uint numr;


    }

    transection valr;
    function rr(uint _amount,address _addr) public {
        valr.amount=_amount;
    valr.timestamp=block.timestamp;
    wdata[_addr].receiver[wdata[_addr].numr]=valr;
    wdata[msg.sender].numr++;
    }

    function getr(address _addr, uint _num) public view  returns(transection memory){
         return wdata[_addr].receiver[_num];
         
    }
    
    mapping (address=> data) public wdata;
    function GetDeposit(address _addr,uint _num) public view returns(transection memory){
        return wdata[_addr].deposits[_num];
    }

    function DetWithdrawls(address _addr,uint _num) public view returns(transection memory){
        return wdata[_addr].withdrawls[_num];
    }

    function getbalance() public view {
        address(this).balance;
    }
    /*function Gettransection(address _addr) public pure returns(transection memory){
        transection memory val3;
        val3.amount;
        val3.timestamp;*/
        
    
        //return val3;

   // }
    function Deposit() public payable  {
       wdata[msg.sender].totalbalance+=msg.value;
        transection memory val=transection(msg.value,block.timestamp);
        wdata[msg.sender].deposits[wdata[msg.sender].numdeposits]=val;
        wdata[msg.sender].numdeposits++;
    }

    function CashOut( address payable  _addr, uint _amount) public {
        wdata[msg.sender].totalbalance-=_amount;
          //uint bal =wdata[msg.sender].totalbalance-=_amount;
        transection memory val2=transection(_amount,block.timestamp);
        wdata[msg.sender].withdrawls[wdata[msg.sender].numcashout]=val2;
        wdata[msg.sender].numcashout++;
        _addr.transfer(_amount);
    }
}