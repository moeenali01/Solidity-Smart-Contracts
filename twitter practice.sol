// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;


contract prr{
    struct student{
        uint roll;
        string name;
    }
    uint id=0;
    mapping(uint=> student)  public data;
    function add(uint roll, string memory name) public   {
        data[id]=student(roll,name);
        id++;
    
    }

        function getdata() public view returns(student[] memory) {
            //uint arrlen= data[key].length;
           student[] memory test= new student[](id);
          // uint j;
           for(uint i=0; i<id;i++){
             //  student storage str=data[i];
              // test[j]=student(str.roll,str.name);
            test[i]=data[i];

              //j++;
           }
            return test;
        }  
    
    

}
