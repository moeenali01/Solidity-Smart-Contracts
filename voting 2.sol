// SPDX-License-Identifier: MIT

pragma solidity >=0.5.0 <0.9.0;
 
    contract Voting {

    address election_commission;
    address public winner;

        struct voter_details{
            string name;
            uint cnic;
            uint voter_id;
            uint voted_candidate;
            address voter_address;
        }

        struct candidate{
            string name;
            string party;
            uint cnicc;
            uint candidate_id;
            address candidate_address;
            uint votes;
        }
    
   // uint start_time;
    uint nextvoterid=1;
    uint public nextcandidateid=1;
    uint voting_time=3600;
    bool stop_voting;
    uint public start_voting=block.timestamp;

        mapping(uint=>voter_details) public voter_data;
        mapping(uint=>candidate) public candidate_data;
        mapping (uint=>voter_details) public voterr;
    

    
    constructor(){
        election_commission==msg.sender;
    }

    modifier votingtiming(){
        require(start_voting+voting_time>start_voting || stop_voting==false, "Voting Over");
        _;
    }

    modifier EC(){
        require(msg.sender==election_commission," Not EC");
        _;
    }

    function candidate_registration(string memory name ,string memory party, uint cnic) public {
        require(candidate_verification(msg.sender)==true, "Already Registered");
        candidate_data[cnic]= candidate(name,party,cnic,nextcandidateid,msg.sender,0);
        nextcandidateid++;
        candidate_verification(msg.sender);
        
    }

    function candidate_verification(address _addr) internal view returns(bool){
        for(uint i=1; i<nextcandidateid;i++){
           if (candidate_data[i].candidate_address== _addr) {
               return false;
           } 
        }
        return true;
    }

    function Canidate_List() public view returns(candidate[] memory){
        candidate[] memory arr= new candidate[](nextcandidateid-1);
        uint j;
        for(uint i=1;i<nextcandidateid;i++){
            arr[j]=candidate_data[i];
            j++;
        }
        return arr;
    }

    function Voter_Registration(string memory name,uint cnic) public {
        require(voter_verification(msg.sender)==true, "Address Already registered");
        require(votercnic(cnic)==true , "Cnic Already registered");
        voter_data[cnic]= voter_details(name,cnic,nextvoterid,0,msg.sender);
        voterr[cnic]=voter_details(name,cnic,nextvoterid,0,msg.sender);
        //voter_verification(msg.sender);
        //votercnic(cnic);
        nextvoterid++;
    }

    function voter_verification(address addr) public view returns(bool){
        for (uint i=0; i<nextvoterid; i++) 
        {
            if (voter_data[i].voter_address==addr) {
               return false; 
            }
        }
        return true;
    }

    function votercnic(uint cnic) public view returns(bool){
        for(uint i=0; i<nextvoterid; i++){
            if(voterr[cnic].cnic==cnic){
                return false;
            }
        }
        return true;
    }


    function voters_list() public view returns(voter_details[] memory) {
        voter_details[] memory arrr= new voter_details[](nextvoterid-1);
        for(uint i=1;i<nextvoterid;i++){
            arrr[i-1]=voter_data[i];
        }
        return arrr;
    }

    function Vote(uint cid,uint _cnic) public {
        require(voterr[_cnic].voted_candidate==0, "Already Votes");
        require(voterr[_cnic].voter_address==msg.sender, "You are not a voter");
        require(start_voting+voting_time>start_voting, "Voting not started");
        require(cid < nextcandidateid && cid>0 , "Invalid Candidate id" );
        candidate_data[cid].votes++;
        voterr[_cnic].voted_candidate=cid;
        voter_data[_cnic].voted_candidate=cid;

    }
    
    }