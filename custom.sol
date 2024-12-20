// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract TraceStorage {
    address public owner;
    uint256 private currentTraceId;

    constructor() {
        owner = msg.sender;
    }

    struct TraceData {
        uint256 traceid;
        string description;
        string keyword;
        string CID;
        address creator; // Store the address of the user who saved the data
    }

    mapping(uint256 => TraceData) private traceDataMapping;
    mapping(string => TraceData) private traceDataKeywordMapping;
    mapping(address => uint256[]) private addressToTraceIds; // Map to store trace IDs against each address
    uint256[] private traceIds;

    event DataSaved(uint256 traceid);

    modifier onlyOwner() {
        require(msg.sender == owner, "Not authorized");
        _;
    }

    function saveData(
        string memory _description,
        string memory _keyword,
        string memory _CID
    ) public returns (uint256) {
        currentTraceId += 1;
        uint256 newTraceId = currentTraceId;

        TraceData memory data = TraceData(
            newTraceId,
            _description,
            _keyword,
            _CID,
            msg.sender // Store the sender's address
        );

        traceDataMapping[newTraceId] = data;
        traceDataKeywordMapping[_keyword] = data;
        traceIds.push(newTraceId);

        // Add the trace ID to the sender's list of trace IDs
        addressToTraceIds[msg.sender].push(newTraceId);

        emit DataSaved(newTraceId);
        return newTraceId;
    }

    function getDataById(
        uint256 _traceid
    ) public view returns (TraceData memory) {
        TraceData memory data = traceDataMapping[_traceid];
        require(data.traceid != 0, "Trace ID does not exist");
        return data;
    }

    function getDatabyKeyword(
        string memory _keyword
    ) public view returns (TraceData memory) {
        TraceData memory data = traceDataKeywordMapping[_keyword];
        return data;
    }

    function getAllData() public view onlyOwner returns (TraceData[] memory) {
        TraceData[] memory dataArray = new TraceData[](traceIds.length);
        for (uint256 i = 0; i < traceIds.length; i++) {
            dataArray[i] = traceDataMapping[traceIds[i]];
        }
        return dataArray;
    }

    // New function to retrieve all data saved by an address
    function GetAssets(address _address) public view returns (TraceData[] memory) {
        uint256[] memory userTraceIds = addressToTraceIds[_address];
        TraceData[] memory dataArray = new TraceData[](userTraceIds.length);

        for (uint256 i = 0; i < userTraceIds.length; i++) {
            dataArray[i] = traceDataMapping[userTraceIds[i]];
        }

        return dataArray;
    }
}
