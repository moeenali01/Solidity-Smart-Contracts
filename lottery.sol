// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract ticket{
    address public owner;
    address payable[] public players;

    constructor(){
        owner=msg.sender;
    }
    receive() external  payable {
        require(msg.value==2 ether, "invalid amount");
        players.push(payable (msg.sender));
    }

    function balance() public view returns(uint){
        require(msg.sender==owner,"You are not the owner");
        return address(this).balance;
    }

    function randon() public view returns(uint){
        //uint initialNumber=0;
         return uint(keccak256(abi.encodePacked(block.timestamp,block.difficulty,  
        msg.sender)));
    }
    function winner() public view returns(address) {
        uint r=randon();
        uint index=r%players.length;
        require(players.length>=3,"limited players");
        address payable winnerplayer;
        winnerplayer= players[index];
        //winnerplayer.transfer(balance()-1);
        return winnerplayer;
    }
    
}