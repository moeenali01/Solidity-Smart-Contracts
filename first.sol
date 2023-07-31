// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

/*contract identity {
    string name;
    uint age;

   constructor() 
   {

       name="Moeen";
       age=21;
   }

    function GetName() view public returns (string memory){
        return name;
    }
    function GetAge() view  public returns (uint){
        return age;
    }
    
    function SetAge() public {
        age=age+1;
    }
    
}

contract example{
    uint public num;
    uint public num2=10;
    string public nam;
    string public name;

    function setnum(uint _num, string memory _nam ) public {
        num=_num+2;
        nam=_nam;
    }
    function setname(string memory namee)public {
        name=namee;
    }
    //constructor(uint _num) {
      //  num=_num;
    //}
   function inc() public {
       num2--;
   }

}

//function GetName() view public returns (string memory){
  //      return name;
contract nft{
    uint public nfts;

    function Total() view public returns (uint){
        return nfts;
    }

    function  AddNft()public {
        nfts++;
    }
    function DelNft()public{
        nfts--;
    }
}*/

/*contract neww {
    uint age=21;
    string name="Moeen Ali";
    function getter() public view returns(uint){
        return age;
    }
    function getterName() public view returns (string memory){
        return name;
    }
    function setter() public {
        age=22;
    }
    function SetterName() public{
        name="Black Eyes";
    }
    function setterInp(uint _age) public {
        age= _age;
    }
    function SetterNameInp(string memory _name) public{
        name=;
    }
}

 contract addresses {
     address public sadd;
     address public newadd;
     function getAddress(address _sadd) public {
         sadd=_sadd;
     }
     function NewAddress() public {
         newadd=0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
     }
     function findbalance()view public returns(uint){
         return newadd.balance;
     }
 }

 contract sum{
     /*function addition(uint _a, uint _b)public pure  returns (uint) {
         uint summ= _a+_b;
         return summ;
     } 

    function get(uint num) public pure returns(uint){
        uint number=num;
        return number;
    }
 }

 contract local{
     uint8 public age;
    function increment()public{
        age=age+1;
    }
     
     constructor(uint8 newage){
         age=newage;
     }
 }

 contract array {
     uint[5] public arr=[1,2,3,4,5];
     uint len;
     function SetArray(uint index,uint value)public{
         arr[index]=value;
     }
     function length()public view returns(uint){
         return arr.length;
         
     }
     function GetArrayLength() public view returns(uint){
         return len;
     }
     function leng() public{
         len=arr.length;
     }
     
 }*/
 /*contract array{
     uint[] public arr;
     function push(uint index, uint value)public{
        arr.push [index];
        arr.push(value);
     }
 }
 pragma solidity ^0.8.0;

contract DynamicArrayExample {
    
    uint[6] public myArray;
    
    function pushValueAtIndex(uint value, uint index) public {
        require(index < myArray.length, "Index out of range");
        myArray[index] = value;
    }
}

contract local{
    uint public gaslimit;
    //constructor() {
      //  gaslimit=tx.gasprice;
      //gaslimit=block.gaslimit;
   // }
    function gas() public {
      //  gaslimit=tx.gasprice;
      gaslimit=block.gaslimit+3;
    }
}

contract add{
    address public anyadd;
    function addresss()public {
        anyadd=msg.sender;

    }
    function addition(uint a,uint b)public pure  returns(uint){
        return a+b;
        
    }
}

contract local{
    uint public num;

    function Number(uint num1)public returns(uint) {
        num=num1;
        return num1;
    }
    function nn(uint num2)public{
        num=num2;
    }
}

contract msgg{
    address public owner;
    uint public counter;
    string public message;
    constructor(){
        owner=msg.sender;
    }

    function UpdateMessage(string memory value)public {
        if(owner==msg.sender){

        
        message= value;
        counter++;
        }
    }
        

}
contract vie{
uint8 a=12;
uint8 b=13;
uint8 c =3;
function get() public view returns(uint8 product,uint8 sum,uint8){
 //product=a*b;
 //sum=a+b;
 return (a,b,c);
}
}*/
/*contract booking{
    uint256 public ticketno;
    uint256 public ticketPrice=10;
    uint256 public TotalAmount;
    uint256 public StartTime;
    uint256 public EndTime;
    uint256 public Timerange;
    string public Message;
    uint public TicketCount;

    constructor(){
        //ticketPrice=price;
        StartTime=block.timestamp;
        EndTime=block.timestamp+10;
        Timerange=(EndTime-StartTime)/60/60/24;
    }

    function BookNow(uint quantity)public returns(uint Ticketid){
        if(ticketPrice>0){
        ticketno++;
        TicketCount=quantity;
        TotalAmount=10*quantity;
        Ticketid=ticketno;}
    }
  
}

contract ifelse{
    string public string1;
    function statement(uint num) public returns (string memory){
        return num==10 ? string1="True": string1="false";
    }
}*/

/*contract loop{
    uint[] public  arr;
    function forr() public returns(uint[] memory){ 
     for (uint i=1; i<=10; i++) 
    {
        arr.push(i);
    }
    return arr;
    }
}*/
 /*contract l{
     uint[] public arr;
     uint public i;
     function whileloop() public {
         while (i<=10) {
           i++;
         
             arr.push(i);
         }
         
         
     } 
 }*/

 /*struct student{
     uint roll;
     string name;
 }
 contract structure{
     student public s1;
     constructor(uint _roll,string memory _name){
         s1.roll=_roll;
         s1.name=_name;
     }

     function Change(uint _roll,string memory _name)public {
         student memory new_student= student({
             roll:_roll,
             name:_name

            
         });
         s1=new_student;
     }
 }
*/

/*contract mapp{
    mapping (uint=> bool) public ub;
    mapping (uint=>string) public es;
    function utb(uint key,bool value) public{
        ub[key]=value;
    }
    function uts (uint num,string memory val) public {
        es[num]=val;
    }
}
*/
/*struct student {
    string name;
    uint roll;
}
contract school{
    student public newstudent;
    student public newstudent2;
    student public newstudent3;
    function data(string memory _name, uint _roll)public {
        newstudent.name=_name;
        newstudent.roll=_roll;
    }
    function data2(string memory _name, uint _roll)public {
        newstudent2.name=_name;
        newstudent2.roll=_roll;
    }
    function data3()public {
        newstudent3.name="BlackEyes";
        newstudent3.roll=58;
    }
    function change()public{
        student memory new_school= student({
            name:"Moeen",
            roll:11
        });
        newstudent3=new_school;
    }
}*/

/*contract mapp{

    struct student {
    string name;
    uint roll;
    uint idd;
}
    //mapping (uint=> bool) public ub;
    mapping (uint=>student) public es;
    //function utb(uint key,bool value) public{
      //  ub[key]=value;
    //}
    function uts (uint id,uint iddd,string memory val, uint roll) public {
        es[id]= student(val,iddd,roll);
    }
}*/

/*contract storagememory{
    string[] public data=["Moin","ali","eyes","black"];
    function mem() public view  {
        string[] memory s1=data;
        
        s1[1]="kingzman";
    }

    function sto() public {
        string[] storage s2=data;
        s2[1]="kingzman";
    }
}*/

/*contract requiree{
    function reqq(uint a) public pure returns (string memory){
        require(a<=3, "approved");
        //require(a>3,"not approved");
        //require(a<3,"invalid");
        return "Blackeyes";
    }

}
*/
/*contract own{
    address public owner;
    constructor(){
        owner=msg.sender;
    }
    modifier onlyowner(){
        require(owner== msg.sender, "Not valid owner");
        _;
    } 

    modifier validation(address addr){
        require(addr!=address(0),"Not valid address");
        _;
    }

    function changeOwner(address newowner) public onlyowner validation(newowner){
        owner=newowner;
    }
}*/

/*contract bal{
    function balance() public payable{

    }
    function sendbalance() public view returns(uint){
        return address(this).balance;
    }
    function withdraw(address payable to) public{
        to.transfer(sendbalance());
    }
}*/

/*contract aa{
    //function reqq(uint u) public pure returns (string memory){
      //  require(u<=10, "U is greater than 10");
        //return "approved";
    //}

    mapping (uint=>bool) public val;
    function aaa(uint num, bool tf) public {
        if (num<10) {
            tf=true;
        }
         else if  (num==100){
             tf=true;
         } 
        val[num]=tf;
    
    }
    
}*/
/*contract mappp{
    mapping (address=>bool) public conversion;
    address public addr;
    function ma()public{
        
        conversion[msg.sender]=true;
    }
    function newadde()public {
        addr=msg.sender;
    }
}*/
/*contract sending{
    string public sendd;
    function send() public payable{
        if(msg.value==1 ether){
            sendd="Moin";
        }
        else{
            payable(msg.sender).transfer(msg.value);
        }
        
    }
}*/

/*contract st{
    struct student {
        string name;
        uint age;
        uint class;
        uint rollno;
        bool tf;
    }
    //uint id;
    student public s1;
    mapping (uint=> student) public data;
    
    function studentdata (uint _id,string memory _name,uint _age,uint _class,uint _rollno,bool _tf) public {
        data[_id]=student(_name,_age,_class,_rollno,_tf);


    }
}*/

/*contract req{
    uint public y;
    function nn(int x ,uint _y) public {
        require(x==2, "invalid inputt");
    //require(x>256,"valid input");
    y=_y;

    }
}

contract own{
    address public owner;
    constructor(){
        owner=msg.sender;
    }
    modifier onlyowner(){
        require(owner==msg.sender,"Invalid owner");
        _;
    }
    modifier addressvalidation(address newaddress){
    require(newaddress!= address(0), "invalid address");
    _;
    }
    function Setnewowner() external onlyowner addressvalidation(_newaddress) {
        
        owner=_newaddress;

    }
    function onlyown() external onlyowner {

    }
    function everyone() external{

    }
}*/

/*contract fn{
    //address payable public owner;
    address payable public daddress=payable(0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db);
    //constructor(){
      //  owner=payable(msg.sender);
    //}
    function deposit() external payable {

    }
    function balance() public view returns(uint)  {
        return address(this).balance;
    }
    //function transferfunds()public  {
      //  daddress.transfer(2 ether);
    //}

    //function transfer(address payable receiver)public  {
      //  receiver.transfer(2 ether);
    //}
function sendViaSend(address payable _to) public payable {
        // Send returns a boolean value indicating success or failure.
        // This function is not recommended for sending Ether.
        bool sent = _to.send(33 ether);
        require(sent, "Failed to send Ether");
    }    
    function SendViaCall(address payable  rec) public payable{
        (bool send,bytes memory data) = rec.call{value:msg.value}("");
        require(send,"failed");
    }

    


}*/

/*contract sending{
    address payable public owner;
    constructor(){
        owner=payable(msg.sender);
    }
    function Chkbalance() external  view  returns(uint){
       return address(this).balance;
    }
    receive() external payable {}

    function Withdrawluint(uint amount) public {
        payable(msg.sender).transfer(amount);
        require(owner==msg.sender, "invalid owner");

    }
}*/

contract mm{
    mapping (string =>uint) public values;
    function EnterData(string memory input,uint salary) public{
        values[input]=salary+2;
    }

}