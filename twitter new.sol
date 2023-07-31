// SPDX-License-Identifier: MIT

pragma solidity >=0.5.0 <0.9.0;

contract NewTweeter{
    struct Tweet{
        uint id;
        address author;
        string content;
        uint time;

    }

    struct Message{
        uint id;
        string content;
        address from;
        address to;
        uint time;
    }

    mapping(uint=>Tweet) public tweets;
    mapping(address=>uint[]) public tweetsOf;
    mapping(address=>Message[] ) public conversations;
    mapping(address=>mapping(address=>bool)) public operators;
    mapping(address=>address[]) public following;

    uint nextid;
    uint nextmsgid;

    function _tweet(address from,string memory content) public {
        //require(operators[from][msg.sender] , "you dont have access");
        tweets[nextid]=Tweet(nextid,from,content,block.timestamp);
        tweetsOf[from].push(nextid);
        nextid++;
    }

    function _sendMessage(address from, address to,string memory content) public{
        conversations[from].push(Message(nextid,content,from,to,block.timestamp));
    }

    function tweet(address from,string memory content) public{
        _tweet(from, content);
    }

    function tweet(string memory content) public{
        _tweet(msg.sender, content);
    }

    function sendMesssage(address from , address to, string memory content) public {
        _sendMessage(from, to, content);
    }

    function sendMessage(address to, string memory content) public{
        _sendMessage(msg.sender, to, content);
    }

    function follow(address follower) public{
        following[msg.sender].push(follower);
    }

    function allow(address addr) public{
        operators[msg.sender][addr]=true;
    }

    function Disallow(address addr) public{
        operators[msg.sender][addr]=false;
    }

    function Get_Latest_Tweets(uint count) public view returns(Tweet[] memory){
        Tweet[] memory _tweets= new Tweet[](count);
        uint j;
        for(uint i=nextid-count;i<nextid;i++){
            //Tweet storage structure= tweets[i];
            //_tweets[j]= Tweet(structure.id,structure.author ,structure.content,structure.time);
            _tweets[j]= tweets[i];
            j++;
        }
        return _tweets;
    } 

    function Fetch_User_Tweets(address user, uint count) public view returns(Tweet[] memory) {
        //uint arrlen=nextid;
        Tweet[] memory utweet= new Tweet[](count);
        uint[] memory ids=tweetsOf[user];
        uint j;
        for(uint i=tweetsOf[user].length-count ;i<tweetsOf[user].length;i++){
            Tweet storage structure=tweets[ids[i]];
            utweet[j]=Tweet(structure.id,structure.author ,structure.content,structure.time);
             
            //utweet[j]=Tweet(structure.id,structure .author,structure.content,structure.time);
            j++;
        }
        return utweet;
    }

    //----------------------------------------
    function All_Fetch_User_Tweets(address user) public view returns(Tweet[] memory) {
        //uint arrlen=nextid;
        Tweet[] memory utweet= new Tweet[](tweetsOf[user].length);
       // uint[] memory ids=tweetsOf[user];
        uint j;
        for(uint i=0 ;i<tweetsOf[user].length;i++){
            //Tweet storage structure=tweets[ids[j]];
            Tweet storage structure=tweets[tweetsOf[user][j]];
            utweet[j]=Tweet(structure.id,structure.author ,structure.content,structure.time);
             
            //utweet[j]=Tweet(structure.id,structure .author,structure.content,structure.time);
            j++;
        }
        return utweet;
    }
}