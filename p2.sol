// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;
contract arrr{
   /*uint[4] public arr =[1,2,3,4];
    function multiply(uint[5] memory num , uint ii) public pure returns(uint[5] memory){
        for(uint i=0;i<num.length;i++){
            num[i]=ii*num[i];
        
        }
        return num;
    }

uint[5] public arr=[1,2,3,4,5];
function storagearray() public returns(uint[5] memory) {
    uint[5] storage sarray;
    sarray=arr;
    sarray[0]=10;
    return arr;
}
function aa() public returns(uint[5] memory){
    return storagearray();
}
    function memoryarray() public view returns(uint[5] memory){
        uint[5] memory marray;
        marray=arr;
        marray[0]=10;
        return marray;
    }

}
contract summ{
   // uint num;
    function total(uint n) public pure returns(uint){
        uint sum=n*(n+1)/2;
        
        
        return sum;
    }
}

contract NaturalNumberSum {
    function calculateSum(uint256 n) public pure returns (uint256) {
        // Initialize sum variable
        uint256 sum = 0;

        // Iterate from 1 to n and calculate the sum
        for (uint256 i = 1; i <= n; i++) {
            sum += i;
        }

        return sum;
    }

    struct student{
        uint id;
        string name;
        uint class;
    }       
    student public s1;
    student public s2;
    function input(uint id,string memory name,uint class) public{
        s1=student(id,name,class);
    }
    function getname() public view  returns(string memory,uint){
        return (s1.name,s1.class);
    }
    function inputt(uint id,string memory name,uint class) public{
        s2=student(id,name,class);
    }

    struct student{
        uint roll;
        string name;
        uint semester;
    }
    student[] public s1;
    function enterdata(uint roll,string memory _name,uint semester) public {
        s1.push(student(roll,_name,semester));

    }
    function returnname(uint i) public view returns(string memory){
        return s1[i].name;
    }
    mapping(uint =>string) public data;
    function adddata(uint id,string memory name) public{
        data[id]=name;
    }
    function getdata(uint id) public view returns(string memory){
        return data[id];
    }
    struct student{
        uint roll;
        string name;
        uint semester;
    }
    mapping(uint=>student) public  sdata;
    uint id=1;
    function adddata(uint roll,string memory name,uint semester) public {
        sdata[id]=student(roll,name,semester);
        id++;
    }
    function getdata(uint num) public view returns(string memory){
        return sdata[num].name;
    }

    struct student{
        uint roll;
        string name;
        uint id;
    }
    mapping(uint=>student) public data;
    function add_data(uint roll, string memory name) public {
        student memory s1;
        uint x=s1.id;
        student memory s2=data[x];
        s2.roll=roll;
        s2.name=name;
        s1.id++;
    }
    struct n{
        uint x;
        string y;
    }
    n  n1;
    function val(uint _x,string memory _y) public  {
         n1.x=_x;
         n1.y=_y;

    }
    function rv() public view returns(string memory){
        //n memory n1;
        return n1.y;
    }
    function val(bool a, string memory b) public {
        val(a,b);
    }*/

    struct data{
        uint roll;
        string name;
    }
    uint id;
    mapping(uint =>data[]) public getdata;
    function add(uint roll, string memory namee) public {
        getdata[id].push(data(roll,namee));

    }

    function getalldata(uint count) public view returns(data[] memory){
        data[] memory _data= new data[](count);
        uint j;
        for(uint i=id;i<id;i++){
        data storage  structure= getdata[i];
            _data[j]=data(structure.roll,structure.name);
            j++;
        }
        return _data;
    }
}   


