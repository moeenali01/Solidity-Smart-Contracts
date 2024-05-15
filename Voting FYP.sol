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
        bool approved;
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


    function voterscount() external view returns(uint){
        return next_voter_id-1;
    }
    function candidatesscount() external view returns(uint){
        return next_candidate_id-1;
    }



    uint start_time;
    uint end_time;

    mapping (uint => voter) voter_details;
    mapping (uint =>candidate) candidate_details;
    mapping (address => bool) public registeredVoters;
    mapping(uint => address) private cnicToAddressMapping;

    mapping (uint => voter) voter_lists;
mapping(uint => uint) private cnicToVoterIdMapping;


    bool stopvoting;

    constructor(){
        Election_Commission=msg.sender;
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
        //require(next_candidate_id<3 , "Candidate Registration Completed");
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
        require(!registeredVoters[msg.sender], "Voter Already Registered with this address");
    require(cnicToAddressMapping[cnic] == address(0) || cnicToAddressMapping[cnic] == msg.sender, "CNIC is already registered with a different address");
        voter_details[cnic]=voter(name,cnic, gender, next_voter_id,0, msg.sender, false);
        voter_lists[next_voter_id]=voter(name,cnic, gender, next_voter_id,0, msg.sender, false);
    cnicToVoterIdMapping[cnic] = next_voter_id; 

         registeredVoters[msg.sender] = true;
         cnicToAddressMapping[cnic] = msg.sender;
        next_voter_id++;
    }


    function approveVoter(uint cnic) public only_election_commissioin {
    require(cnic != 0, "Invalid CNIC");
    require(cnicToAddressMapping[cnic] != address(0), "Voter does not exist.");

    uint voterId = cnicToVoterIdMapping[cnic]; 
    require(voterId != 0, "Voter ID not found for given CNIC.");

    voter storage v = voter_details[cnic];
    require(!v.approved, "Voter already approved.");
    v.approved = true;

    voter storage vList = voter_lists[voterId];
    vList.approved = true;
}





    /*function voter_verification(address _person) internal view returns(bool){
        for (uint i=1; i<next_voter_id; i++) 
        {
            if(voter_details[i].voter_address==_person){
                return false;
            }
        }
        return true;
    }*/
//==================================================================
    function Voter_List() public view returns(voter[] memory){
        voter[] memory arr= new voter[](next_voter_id-1);
        for (uint i=1; i<next_voter_id; i++) 
        {
            arr[i-1]= voter_lists[i];
        }

        return arr;
    }   

 //=======================================================================   


    function Approved_Voter_List() public view returns(voter[] memory) {
    uint approvedCount = 0;
    for (uint i = 1; i < next_voter_id; i++) {
        if (voter_lists[i].approved) {
            approvedCount++;
        }
    }
    
    voter[] memory approvedVoters = new voter[](approvedCount);
    
    uint arrayIndex = 0; 
    for (uint i = 1; i < next_voter_id; i++) {
        if (voter_lists[i].approved) {
            approvedVoters[arrayIndex] = voter_lists[i];
            arrayIndex++;
        }
    }
    
    return approvedVoters;
}




//================================================================


function UnApproved_Voter_List() public view returns(voter[] memory) {
    uint approvedCount = 0;
    for (uint i = 1; i < next_voter_id; i++) {
        if (!voter_lists[i].approved) {
            approvedCount++;
        }
    }
    
    voter[] memory approvedVoters = new voter[](approvedCount);
    
    uint arrayIndex = 0; 
    for (uint i = 1; i < next_voter_id; i++) {
        if (!voter_lists[i].approved) {
            approvedVoters[arrayIndex] = voter_lists[i];
            arrayIndex++;
        }
    }
    
    return approvedVoters;
}



//=================================================================








    function vote(uint cnic, uint candidate_id) public{
    require(block.timestamp >= start_time, "Voting has not started yet");
    require(block.timestamp <= end_time, "Voting is over");
    require(voter_details[cnic].voted_candidate_id == 0, "You already voted");
    require(cnicToAddressMapping[cnic] == msg.sender, "CNIC does not match the voter address");
    require(candidate_id >= 1 && candidate_id < next_candidate_id, "Invalid candidate ID");
    require(voter_details[cnic].approved, "You are not an approved voter");

    
    voter_details[cnic].voted_candidate_id = candidate_id;
    candidate_details[candidate_id].votes++;
}


    function Vote_time(uint _start_time, uint _end_time) external only_election_commissioin(){
        require(_end_time > _start_time, "End time must be after start time.");
        start_time= _start_time;
        end_time= _end_time;
    }

    function votingStatus() public view returns (string memory) {
    if (block.timestamp < start_time) {
        return "Voting not started yet";
    } else if (block.timestamp >= start_time && block.timestamp <= end_time && !stopvoting) {
        return "Voting in Progress";
        } else if (start_time==0) {
        return "Voting not started yet";
    } else {
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