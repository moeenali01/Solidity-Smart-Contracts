// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;
contract Wallet{

    struct transection{
        uint amount;
        uint timestamp;
    }
    struct balance{
        uint totalbalance;
        uint numdeposits;
        mapping(uint => transection)deposits;
        uint withdrawl;
        mapping(uint =>transection) withdrawls;
         //address receiverd;
    //mapping (address=>transection)r;
    }
    mapping (address=>transection)r;

    }
    
    mapping (address=>balance)  data;

    function GetRD(address _to) public {
        transection memory val3= transection(msg.value,block.timestamp);
       data[_to].r[data[_to].receiverd=val3];
       data[_to].receiverd;
    
        
    }

//data[msg.sender].deposits[data[msg.sender].numdeposits]=val;
  //      data[msg.sender].numdeposits++;
    /*function ReceiverData(address _to) public   {
        transection memory val2= transection(_to.balance,block.timestamp);
        data[_to].receiver[data[_to].deposits]=val2;
    }*/

    function GetDepositData(address _daddress, uint _dnum) public view returns(transection memory) {
       return  data[_daddress].deposits[_dnum];
    }
    function GetReceiverData(address _address) public view returns(uint, uint){
        //data[_address].receiver[_address];
        return (_address.balance,block.timestamp);
    }

    function GetWithdrawData(address _daddress, uint _amount) public view returns(transection memory) {
       return  data[_daddress].withdrawls[_amount];
    }
    transection val;
   // balance val2;

    function DeposotMoney() public payable {
        data[msg.sender].totalbalance +=msg.value;
        //transection memory val= transection(msg.value,block.timestamp);
        val.amount=msg.value;
        val.timestamp=block.timestamp;
        

        //data[msg.sender]=val2.deposits;
        data[msg.sender].deposits[data[msg.sender].numdeposits]=val;
        data[msg.sender].numdeposits++;
    }

    function withdraw(address payable  _receiver, uint _amount) public {
        data[msg.sender].totalbalance-=_amount;
       transection memory val2= transection(_amount,block.timestamp);

        data[msg.sender].withdrawls[data[msg.sender].withdrawl]=val2;
        data[msg.sender].withdrawl++;

        _receiver.transfer(_amount);

    }

    function Balance() public view returns(uint){
        return address(this).balance;
    }



