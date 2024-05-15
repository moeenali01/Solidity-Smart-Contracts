// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0; 

contract Voting{
    address Election_Commission;
    address public winner;

    struct voter{
        string name;
        uint cnic;
        string gender;
        uint voterid;
        uint voted_candidate_id;
        address voter_address;
    }

    struct candidate{
        string name;
        uint cnic;
        string party;
        string gender;
        uint candidate_id;
        address candidate_address;
        uint votes;
    }

    uint next_voter_id=1;
    uint next_candidate_id=1;

    uint start_time;
    uint end_time;

    mapping (uint => voter) voter_details;
    mapping (uint =>candidate) candidate_details;
    bool stopvoting;

    constructor(){
        Election_Commission = msg.sender;
    }

    modifier is_voting_over(){
        require(block.timestamp>end_time || stopvoting==true , "Voting is Over");
        _;
    }

    modifier only_election_commissioin(){
        require(msg.sender==Election_Commission , "You are not Election Commision");
        _;
    }

    function Candidate_Registration(string memory _name, uint _cnic, string memory _party, string memory _gender) public {
        require(msg.sender!= Election_Commission, "You are Election Commission");
        require(Candidate_Verification(msg.sender), "Candidate ALready Registered");
        require(next_candidate_id<3 , "Candidate Registration Completed");
        candidate_details[next_candidate_id]=candidate(_name,_cnic,_party,_gender,next_candidate_id,msg.sender,0);
        next_candidate_id++;
    }

    function Candidate_Verification (address _person) internal view returns(bool){
        for (uint i=1; i<next_candidate_id; i++) 
        {
           if (candidate_details[i].candidate_address==_person){
            return false;
           }
    }
            return true;
        }
        

     function Candidate_List() public view returns(candidate[]memory){
        candidate[] memory array = new candidate[](next_candidate_id-1);
        for (uint i=1; i<next_candidate_id; i++) 
        {
            array[i-1]=candidate_details[i];
        }
        return array;
     }  

    function Voter_Registration(string calldata name, uint cnic, string calldata gender) public {
        require (voter_verification(msg.sender) , "Voter Already Registered");
        voter_details[next_voter_id]=voter(name,cnic, gender, next_voter_id,0, msg.sender);
        next_voter_id++;
    }

    function voter_verification(address _person) internal view returns(bool){
        for (uint i=1; i<next_voter_id; i++) 
        {
            if(voter_details[i].voter_address==_person){
                return false;
            }
        }
        return true;
    }

    function Voter_List() public view returns(voter[] memory){
        voter[] memory arr= new voter[](next_voter_id-1);
        for (uint i=1; i<next_voter_id; i++) 
        {
            arr[i-1]= voter_details[i];
        }

        return arr;
    }   

    function vote(uint voter_id, uint candidate_id) public{
        require(voter_details[voter_id].voted_candidate_id==0, "You alreay voted");
        require(voter_details[voter_id].voter_address==msg.sender, "You are not Voter");
        require(start_time!=0, "Voting not started yet");
        require(next_candidate_id>1 && next_candidate_id<3, "Invalid Candidte Id");
        require(next_candidate_id==3, "Candidated not registered yet");
        voter_details[voter_id].voted_candidate_id=candidate_id;
        candidate_details[voter_id].votes++;
    }

    function Vote_time(uint _start_time, uint _end_time) external only_election_commissioin(){
        start_time= _start_time;
        end_time= _start_time+ _end_time;
    }

    function voting_status() public view returns (string memory){
        if (start_time==0) {
            return "Voting not starting";
        }
        else if(start_time==0 && end_time> block.timestamp && stopvoting==false){
            return "Voting in Progress";
        }
        else{
            return "Voting is Over";
        }
    }

    function emergency() public only_election_commissioin(){
        stopvoting=true;
    }

    function Result() external only_election_commissioin(){
        if(candidate_details[1].votes>candidate_details[2].votes){
            winner= candidate_details[1].candidate_address;
        }
        else{
            winner= candidate_details[2].candidate_address;
        }
    }
}