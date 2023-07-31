// SPDX-License-Identifier: MIT

pragma solidity >=0.5.0 <0.9.0;

contract Dao_Project{
    struct proposal{
        uint id;
        string description;
        uint amount;
        address payable receiver;
        uint votes;
        uint end;
        bool executed;
    }

    mapping (address=>bool) private investor;
    mapping(address=> uint) private numshares;
    mapping(address=>mapping(uint=>bool)) voted;
    mapping(address=>mapping (address=>bool)) withdraw_status;

    address[] public investors;
    mapping(uint=> proposal) public proposal_List;

    //uint public total_shares;
    uint public funds;
    uint public total_shares;
    uint public contribution_Time_End;
    uint public voting_time;
    uint public nextproposalid;
    address public manager;
    uint public quoram;

    constructor(uint _quoram,uint contribution_time,uint vote_time) {
        manager=msg.sender;
        quoram=_quoram;
        contribution_Time_End=block.timestamp+contribution_time;
        voting_time=vote_time;

    }
    modifier onlyinvestor{
        require(investor[msg.sender]==true, "You are not investor");
        _;
    }
    modifier onlymanager{
        require(manager==msg.sender, "You are not manager");
        _;
    }

    function Contribution() public payable  {
        require(msg.value>0, "invalid amount");
        require(contribution_Time_End>=block.timestamp, "Time passed");
        investor[msg.sender]==true;
        numshares[msg.sender]+=msg.value;
        total_shares+=msg.value;
        funds+=msg.value;
        investors.
        push(msg.sender);
    }

    function Redeem_Shares(uint amount) public {
        require(numshares[msg.sender]>amount, "Not enough shares");
        require(funds>amount, "Not enough funds");
        numshares[msg.sender]-=amount;
        if (numshares[msg.sender]==0) {
            investor[msg.sender]=false;

        }
        funds-=amount;
        payable (msg.sender).transfer(amount);
        
    }

    function Transfer_Share(uint amount, address payable receiver) public {
         require(numshares[msg.sender]>amount, "Not enough shares");
         require(funds>amount, "Not enough funds");
         numshares[receiver]+=amount;
         if (numshares[msg.sender]==0) {
            investor[msg.sender]=false;}
            investor[receiver]=true;
            investors.push(receiver);
         
         numshares[msg.sender]-=amount;

    }

    function Create_proposal(string calldata description,uint amount, address payable receiver) public onlymanager{
        require(funds>=amount, "Not enough funds");
        proposal_List[nextproposalid]=proposal(nextproposalid,description,amount,receiver,0,block.timestamp+voting_time,false);
        nextproposalid++;
    }

    function Vote_proposal(uint pid) public onlyinvestor {
        proposal storage structure= proposal_List[pid];
        require(pid<=nextproposalid, "Invalid proposal id");
        require(structure.end>=block.timestamp, "TIme Ended");
        require(structure.executed==false, "Proposal Already Executed");
        require(voted[msg.sender][pid]==false, "You already voted");
        voted[msg.sender][pid]=true;
        structure.votes+=numshares[msg.sender];
    }

    function Execute_Proposal(uint pid) onlymanager public {
        proposal storage structure= proposal_List[pid];
        require(((structure.votes*100)/total_shares)>quoram, "Majority doesnot supports");
        structure.executed==true;
        funds-=structure.amount;  
        _transfer(structure.amount,structure.receiver);      
    }
        function _transfer(uint amount ,address payable receiver) public{
            receiver.transfer(amount);
        }

    function Fetch_All_Proposals() public view returns(proposal[] memory) {
        proposal[] memory arr= new proposal[](nextproposalid-1);
        for(uint i=0; i<=nextproposalid;i++){
            //uint j;
           // proposal storage str=proposal_List[i];
            //arr[i]=proposal(str.id,str.description,str.amount,payable(str.receiver),str.votes,str.end,str.executed);
            arr[i]=proposal_List[i];
            //j++;
        }
        return arr;


    }
    function all_Investors() public view returns(address[] memory){
        return investors;
    }

}