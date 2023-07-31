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
        uint nextid;
        mapping(uint=>string) edataa;
       
    }
    //uint public  newid;
    Event public e2;
   
    
    modifier edate(){
        require(e2.date>block.timestamp, "date passed");
        _;
    }
    modifier ecount(){
        require(e2.ticket_Count>0,"Add more tickets");
        _;
    }
    mapping(uint=>Event) public eventdata;
    //mapping(uint=>string) public edata;
    //mapping(uint=>Event) echk;
    /*function chk() public{
        Event storage e2; 
        echk[nextid]=e2.Event_Name;
    }*/
    
    function Register_Event(string memory _name,uint date,uint _price,uint _count,string memory _speaker) public{
         //require(Event.ticket_Count>0,"Add more tickets");
       // Event memory e2;
        e2[e2.nextid].organizer=msg.sender;
        e2[e2.nextid].Event_Name=_name;
        e2[e2.nextid].date=date;
        e2[e2.nextid].price=_price;
        e2[e2.nextid].ticket_Count=_count;
        e2[e2.nextid].remaining_tickets=_count;
        e2[e2.nextid].speaker=_speaker;

        // eventdata[e2.nextid]=e2.Event_Name;

        //eventdata[e2.nextid]=Event(msg.sender,_name,date,_price,_count,_count,_speaker);
        eventdata[e2.nextid].edataa[eventdata[e2.nextid].nextid]=e2.Event_Name;
        eventdata[e2.nextid].nextid++;
        //edata[nextid]=e1.Event_Name;
    }

    function Getedata(uint _id) public  view returns(string memory){
        return  eventdata[_id].edataa[e2.nextid];
        
    }
}