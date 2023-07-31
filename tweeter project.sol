// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract tweeter{

    struct tweetdata{
        uint id;
        address creator;
        string content;
        uint time;
    }

    struct message{
        uint id;
        address from;
        address to;
        uint time;
        string msgcontent;
    }

    mapping(uint=>tweetdata) public Tweet;
    mapping(address=>uint[]) public tweetof;
    mapping(address=>message[]) public conversation;
    mapping(address=>mapping(address=>bool)) public operators;
    mapping(address=>address[]) public following;

    uint nextid;
    uint nextmsgid;

    function posttweet(address from, string memory content) internal  {
        Tweet[nextid]=tweetdata (nextid,from,content,block.timestamp);
        nextid++;
    }

    function Send_Message(address from, address to, string memory content) internal {
        conversation[from].push(message(nextmsgid,from,to,block.timestamp,content));
    }

    function Tweett(string memory content) public {
        posttweet(msg.sender, content);
    }

    function Tweett(address from,string memory content) public {
        posttweet(from,content);
    }

    function SendMessage(address to,string memory content) public {
        Send_Message(msg.sender, to, content);
    }

    function SendMessage(address from, address to, string memory content)public {
        Send_Message(from, to, content);
    }
    function Follow(address follower_address) public  {
        following[msg.sender].push(follower_address);
    }

    function allow(address addr) public {
        operators[msg.sender][addr]=true;
    }

    function disallow(address addr) public {
        operators[msg.sender][addr]=false;
    }
    
    function Get_Latest_Tweet(uint count) public view returns(tweetdata[] memory) {
        require(count>0 && count<=nextid, "Invalid Count");
        tweetdata[] memory _tweetdata= new tweetdata[](count);

        uint j;
        for(uint i=nextid-count;i<nextid;i++){
            tweetdata storage structure= Tweet[i];
            _tweetdata[j]=tweetdata(structure.id,structure.creator,structure.content,structure.time);
            j++;
        }
        return _tweetdata;
    }
        
    
}