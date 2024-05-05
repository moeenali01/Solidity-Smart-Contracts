// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract mappings{

    mapping (uint=>string) public students;
    function set(uint roll, string memory name) public {
        students[roll]=name;
    }
    uint serial;
    mapping (uint=>mapping (uint=>string)) public reg;
    function registation(uint roll, string memory name) public {
        
        reg[serial][roll]=name;
        serial+=1;
    }
}