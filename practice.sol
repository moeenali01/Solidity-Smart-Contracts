// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

/*contract pra{
    address public sender;
    constructor(){
        sender=msg.sender;
    }
    function senderr() public {
        sender=msg.sender;
    }

    uint public num;
    function increment() public{
        num++;
        require(num<5);
    }

    function assigned() public view  returns (uint x, bool b, uint y,address d) {
        x = 1;
        b = true;
        y = 2;
        d=msg.sender;
    }
    

}

contract Function {
    // Functions can return multiple values.
    function returnMany() public pure returns (uint, bool, uint) {
        return (1, true, 2);
    }

    function wih() public view returns(bool,uint,address){
        (,bool a,uint b)=returnMany();  
        address c=msg.sender;
        return(a,b,c);
    }


}

contract mappp{
    mapping(address=>uint) public bal;
    function chk() public payable  {
        bal[msg.sender]=123;
        uint balance=bal[msg.sender];
        uint balance2=bal[address(1)];

        bal[msg.sender]+=msg.value;
    }

    uint[] public arr;
    function add(uint _num) public {
    for (uint i=0; i<=arr.length; i++) 
    {
        arr.push(_num);
    }
        
    }
}

contract NestedMapping {
    // Nested mapping (mapping from address to another mapping)
    mapping(address => mapping(uint => bool)) public nested;

    function get(address _addr1, uint _i) public view returns (bool) {
        // You can get values from a nested mapping
        // even when it is not initialized
        return nested[_addr1][_i];
    }

    function set(address _addr1, uint _i, bool _boo) public {
        nested[_addr1][_i] = _boo;
    }
}
*/
/*contract mapppp{
    struct eventt {
        string name;

    }
    eventt e3;
    uint id=1;
    //string name="moin";
    mapping(uint=>string) public dataa;
    function add(string memory _name) public{
        
        e3.name=_name;

    }
    function chk(uint _id) public returns(string memory){
        id=_id;
        id++;
        eventt memory e2;
        dataa[_id]=e2.name;
        return dataa[id];
    
    }

}

contract neww{
    struct student{
        string name;
        uint roll;
        //uint id;
    }
    uint id;
    mapping(uint=>student) us;
    function data(string memory _name,uint _roll) public{
        student memory s1;
        s1.name=_name;
        s1.roll=_roll;
        us[id]=s1;
        id++;
    }
    function get(uint _id) public view returns (student memory){
        return us[_id];
    }
    
}*/
/*contract structinside{

   // uint totalstudent;
    struct student {
        //uint total_student;
        //string name;
        string subject;
        uint semester;
        uint credithours;

    }

    struct edu{
        string name;
        string uni;
        string dpt;
        uint gpa;
        //uint roll;
        uint id;
        mapping(uint=>student) sdata;
    }
    mapping (uint=>edu) public sndata;
uint id=1;
    function setdata(uint roll,string memory name,string memory uni,string memory dpt,uint gpa, string memory subject,uint semester,uint credithour) public{
        edu storage s1=  sndata[id];
        s1.name=name;
        s1.uni=uni;
        s1.dpt=dpt;
        s1.gpa=gpa;
        //s1.roll=roll;
        student memory s2= student(subject,semester,credithour);
        //s1.sdata[s1.id]=s2;
        //sndata[s1.id].sdata[sndata[s1.id].id]=s2;
        
    }
    function getdata(uint _id) public view returns(student memory){
        
    
        
    }
    
}*/

contract mm{
    function f1() public pure  returns(uint ){
        return 1;
    }
    function f2() private   pure  returns(uint ){
        return 1;
    }
    function f3() internal  pure  returns(uint ){
        return 1;
    }
    function f4() external  pure  returns(uint ){
        return 1;
    }
}
contract nn{
    mm obj=new mm();
    uint public x=2;
    function neww() public{
        x=obj.f4();
    }
}