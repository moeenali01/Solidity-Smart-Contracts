// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;
contract organizer{
    struct Event{
        address organizer;
        string Event_Name;
        //uint date;
        uint price;
        uint ticket_Count;
        uint remaining_tickets;
        string speaker;
        //uint eventid;
        //mapping(string=>uint) edata;
        }
        struct count{
            uint eventcount;
            mapping(string=>Event) edata;
        }
       // uint eventid;

        mapping (uint=>Event) eventdata;
        mapping(uint=>count) eventtdata;
       
        function Register(uint id,string memory name,uint price,uint tcount,uint tremain,string memory speaker) public{
            Event memory e1=Event(msg.sender,name,price,tcount,tremain,speaker);
            count storage e2;
            eventdata[id]=e1;
            eventtdata[id].edata[eventtdata[id].eventcount]=e1;

        }

       
    }