// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;


contract TextileSupplyChain {
    address public owner;

    mapping(address => bool) public farmers;
    mapping(address => bool) public manufacturers;
    mapping(address => bool) public distributors;
    mapping(address => bool) public retailers;

    enum Stage {
        Farming,
        Manufacturing,
        Distribution,
        Retail
    }

    struct Batch {
        string batchId;
        Stage stage;
        address currentHandler;
    }

    mapping(string => Batch) public batches;

    event BatchCreated(string batchId);
    event StageAdvanced(string batchId, Stage stage);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function assignFarmer(address _farmer) public onlyOwner {
        farmers[_farmer] = true;
    }

    function assignManufacturer(address _manufacturer) public onlyOwner {
        manufacturers[_manufacturer] = true;
    }

    function assignDistributor(address _distributor) public onlyOwner {
        distributors[_distributor] = true;
    }

    function assignRetailer(address _retailer) public onlyOwner {
        retailers[_retailer] = true;
    }

    function createBatch(string memory _batchId) public {
        require(farmers[msg.sender], "Only farmers can create new batches");
        batches[_batchId] = Batch(_batchId, Stage.Farming, msg.sender);
        emit BatchCreated(_batchId);
    }

    function advanceStage(string memory _batchId) public {
        Batch storage batch = batches[_batchId];
        require(msg.sender == batch.currentHandler, "Only current handler can advance the stage");

        if (batch.stage == Stage.Farming) {
            require(manufacturers[msg.sender], "Only manufacturers can receive from farmers");
            batch.stage = Stage.Manufacturing;
        } else if (batch.stage == Stage.Manufacturing) {
            require(distributors[msg.sender], "Only distributors can receive from manufacturers");
            batch.stage = Stage.Distribution;
        } else if (batch.stage == Stage.Distribution) {
            require(retailers[msg.sender], "Only retailers can receive from distributors");
            batch.stage = Stage.Retail;
        }

        batch.currentHandler = msg.sender;
        emit StageAdvanced(_batchId, batch.stage);
    }

}
