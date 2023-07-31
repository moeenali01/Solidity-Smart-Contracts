// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;
contract organizer{
    struct Event{
        address organizer;
        string Event_Name;
        uint date;
        uint price;
        uint ticket_Count;
        uint remaining_tickets;
        string speaker;
       
    }
    uint public  nextid;
    Event public e1;
   
    
    modifier edate(){
        require(e1.date>block.timestamp, "date passed");
        _;
    }
    modifier ecount(){
        require(e1.ticket_Count>0,"Add more tickets");
        _;
    }
    mapping(uint=>mapping(string=>Event)) public eventdata;
    mapping(address=>mapping(uint=>uint))public ticket;
    mapping(string=>uint) public Eventdata;
    //mapping(uint=>string) public edata;
    //mapping(uint=>Event) echk;
    /*function chk() public{
        Event storage e2; 
        echk[nextid]=e2.Event_Name;
    }*/

    function eventdataa(string memory idd) public returns(uint){
        Eventdata[e1.Event_Name]=nextid;
        return Eventdata[idd];
    }
    
    function Register_Event(string memory _name,uint date,uint _price,uint _count,string memory _speaker) public{
         //require(Event.ticket_Count>0,"Add more tickets");

        eventdata[nextid][_name]=Event(msg.sender,_name,date,_price,_count,_count,_speaker);

        nextid++;
        //edata[nextid]=e1.Event_Name;
    }

    /*function Getedata(uint _id) public  returns(string memory){
         edata[nextid]=e1.Event_Name;
        return edata[_id];
    }*/

    function buynewticket(uint id,uint _quantity) public {
    
        ticket[msg.sender][id]+=_quantity;
        e1.remaining_tickets-=_quantity;



    }
}