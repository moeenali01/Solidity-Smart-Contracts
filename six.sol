// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

/*contract BalanceChecker {
    
    mapping(address => uint256) public addressBalance;
    
    function checkBalance(address _addressToCheck) public view returns (uint256) {
        return addressBalance[_addressToCheck];
    }
    
    function Receive() public payable {
        addressBalance[msg.sender] += msg.value;
    }
}
*/
contract test {
   struct Book { 
      string title;
      string author;
      uint book_id;
   }
   Book book;

   function setBook() public {
      book = Book('Learn Java', 'TP', 1);
   }
   function getBookId() public view returns (string memory) {
      return book.author;
   }
}

contract wallet{
    struct transection{
        uint amount;
        uint timestamp;
    }
    struct  balance{
        uint totalbalance;
        uint numdeposits;
        mapping(uint => transection)deposits;
        uint withdrawl;
        mapping(uint =>transection) withdrawls;
         //address receiverd;
    //mapping (address=>transection)r;
    }
    mapping (address=>balance) public data;

    
   

    function DeposotMoney() public payable {
        data[msg.sender].totalbalance +=msg.value;
        //transection memory val= transection(msg.value,block.timestamp);
        transection memory val;
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
     function GetDepositData(address _daddress, uint _dnum) public view returns(transection memory) {
       return  data[_daddress].deposits[_dnum];
    }
    function GetWithdrawData(address _daddress, uint _amount) public view returns(transection memory) {
       return  data[_daddress].withdrawls[_amount];
    }
}