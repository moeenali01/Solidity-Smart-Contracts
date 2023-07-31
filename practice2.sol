// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;
contract arrr{
  /* uint[] public marks;
   mapping (address=>string[]) public data;
   function add_data(address _addr, string memory _nums) public {
       data[_addr].push(_nums);
   }
    function getdata(address _addr,uint num) public view returns(string memory){
        return data[_addr][num];
    }*/

    struct student{
        uint roll;
        string name;
        string department;
    }
    mapping(uint=>student[]) public students_data;
    uint id;
    function add_student (uint roll,string memory name, string memory department) public {
        students_data[id].push(student(roll,name,department));
        id++;
    }

    function Get_all_students(uint count) public view returns(student[] memory) {
        student[] memory _stu= new student[](count);
        uint j;
        for(uint i=id-count;i<id;i++){
            student storage str=students_data[i];
            _stu[j] =student(str.roll,str.name,str.department);
            j++;


        }
        return student;
    }
}