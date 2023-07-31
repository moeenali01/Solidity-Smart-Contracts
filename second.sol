// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

/*contract mapp{
    struct student {
        uint roll;
        string name;
        bool pf;
    }
    mapping (uint=>student) public data;
    function EnterData(uint _id,uint _roll,string memory _name, bool _pf) public {
        if (_id==1) {
            _pf=false;
        }
        data[_id]=student(_roll,_name,_pf);
        

    }
}*/




/*contract mappp{
    mapping (address=>bool) public data;
    mapping (uint=>bool) public value;
    function addr() public{
        data[msg.sender]=true;
    }
    function setvalue(uint num) public {
        value[num]=true;
    }
}*/

contract wallet{
    function deposit() payable public{}

    function Balance() public view returns  (uint){
        return address (this).balance;
    }

    function CashOut(address payable _addr) public {
        _addr.transfer(Balance());
    }

}
contract to{
    struct todo{
        string text;
        bool done;
    }

    todo[] public data;
    function SetData(string memory _text) public{
        data.push (todo({text:_text,
        done:false}));
    }

    function update(uint _index, string memory _text) public {
        todo storage val=data[_index];
        val.text=_text;
    }
    
    function Getdata(uint _num) external  view returns(string memory,bool){
        todo memory dataa=data[_num];
        return (dataa.text, dataa.done);

    }

    function toggle(uint _num) public {
        data[_num].done=!data[_num].done;
    }
}

contract withmap{
    struct data{
        string text;
        bool completed;
    }
    mapping(uint=>data) public sdata;

    function SetData(uint id,string memory val,bool tf) public{
        sdata[id]=data(val,tf);
    }

    function Update(uint id,string memory val,bool tf) public{
        sdata[id]=data(val,tf);
    }
}

/*contract vault{
    
mapping(address => uint) public balanceReceived;
function sendMoney () public payable {
    balanceReceived [msg.sender] += msg.value;
}

function getBalance() public view returns (uint) { 
    return address (this).balance;
}
function withdrawAllMoney (address payable to) public { 
    uint balanceToSendOut = balanceReceived [msg.sender]; 
    balanceReceived [msg.sender] = 10;
 to.transfer (balanceToSendOut);
}
}*/
contract mapp{

    struct student {
    string name;
    uint roll;
    uint idd;
    uint id;
}
    //mapping (uint=> bool) public ub;
    mapping (uint=>student) public es;
    //function utb(uint key,bool value) public{
      //  ub[key]=value;
    //}
    uint id=1;
    function uts (uint iddd,string memory val, uint roll) public {
        es[id].name=val ;
        es[id].roll=roll ;
        es[id].idd=iddd ;
        es[id].id=id;
        id++;
    }
}

contract bank{
    struct customer{
        address owner;
        uint balance;
        uint accountcreatedtime;
        string message;
    }
    mapping(address=>customer) public abl;
    modifier min(){
        require(msg.value>=1 ether, "Low balance");
        _;
    }

    function AccountCreated() public payable min{
        abl[msg.sender]=customer({owner:msg.sender,balance:msg.value,accountcreatedtime:block.timestamp,message:"Account Created /successfully"});
    }

    function Deposit() public payable min{
        abl[msg.sender].balance+=msg.value;
        abl[msg.sender].message="Deposit Successfully";
    }
    function Balance() public view returns(uint){
        return address(this).balance;
    }

    function Withdrawl() public payable {
        payable(msg.sender).transfer(abl[msg.sender].balance);
        abl[msg.sender].balance=10;
    }
}
//------------------------------------------------------------


contract bank2{
    struct customer{
        address owner;
        uint balance;
        uint accountcreatedtime;
    }
    mapping(address=>customer) public abl;
    modifier min(){
        require(msg.value>=1 ether, "Low balance");
        _;
    }

    function AccountCreated() public payable min returns (uint){
        abl[msg.sender]=customer({owner:msg.sender,balance:msg.value,accountcreatedtime:block.timestamp});
        customer memory cc;
        return cc.balance;
    }

    function Deposit() public payable min{
        abl[msg.sender].balance+=msg.value;
    }
    function Balance() public view returns(uint){
        return address(this).balance;
    }

    function Withdrawl(address payable _receiveraddress, uint _amount ) public {
        payable(_receiveraddress).transfer(_amount);
        abl[msg.sender].balance-=_amount;
        customer memory cbalance;
        require(address(this).balance>=cbalance.balance, "Low balance");
        abl[msg.sender].balance=0;
    }
}