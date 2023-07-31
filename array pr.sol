// SPDX-License-Identifier: MIT

pragma solidity >=0.5.0 <0.9.0;

contract MappingTest {
    mapping(uint=>address) public addresses;
    uint addressRegistryCount;

    function set(address userAddress) public{
        addresses[addressRegistryCount] = userAddress;
        addressRegistryCount++;
    }

    function getAll() public view returns (address[] memory){
        address[] memory ret = new address[](addressRegistryCount);
        for (uint i = 0; i < addressRegistryCount; i++) {
            ret[i] = addresses[i];
        }
        return ret;
    }
}       
contract practice{
    mapping(address=>uint[]) public arr;
    uint id;
    function adduser(address _from) public {
        arr[_from].push(id);
        id++;
    }
    function add(address user) public view returns(uint[] memory) {
        return arr[user];
    }
}