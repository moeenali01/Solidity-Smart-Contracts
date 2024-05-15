// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19; 

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
//import "hardhat/console.sol";

contract nftmarketplace is ERC721URIStorage{
using Counters for Counters.Counter;

Counters.Counter private _tokenIds;
Counters.Counter private _itemSold;

uint256 listingprice= 0.0025 ether;

address payable owner;
mapping(uint256=> MarketItem) private idMarketItem;

struct MarketItem{
    uint tokenId;
    address payable seller;
    address payable owner;
    uint256 price;
    bool sold;
}

    event Marketitemcreated(
        uint256 indexed tokenid,
        address seller,
        address owner,
        uint256 price,
        bool sold
    );
    
    constructor() ERC721("NFT Metaverse Token" , "EYES"){
        owner= payable(msg.sender);
    }

    modifier onlyowner{
        require(msg.sender==owner, "You are not the owner");
        _;
    }

    function updateListingPrice(uint _listingPrice) public payable onlyowner{
        listingprice=_listingPrice;

    }

    function CheckListingPrice() public view returns(uint){
        return listingprice;
    }

    //NFT Function

    function createToken(string memory tokenURI , uint256 price) public payable returns(uint256){
        _tokenIds.increment();
        uint256 newTokenId= _tokenIds.current();
        _mint(msg.sender, newTokenId);
        _setTokenURI(newTokenId, tokenURI);

        createMarketItems(newTokenId, price);
        return newTokenId;
    }
//Creting MArket Item
    function createMarketItems(uint256 tokenId, uint256 price) private{
        require(price>0, "Price must me atleast 1");
        require(msg.value==listingprice, "price must be equal to listing price");
        idMarketItem[tokenId]= MarketItem(tokenId, payable(msg.sender), payable(address(this)),price,false);
        _transfer(msg.sender, address(this), tokenId);

        emit Marketitemcreated(tokenId, msg.sender, address(this), price, false);
    }

    //Resale Tokem

    function ReSale(uint256 tokenid, uint price)public payable{
        require(idMarketItem[tokenid].owner==msg.sender, "You are not the owner");
        require(msg.value==listingprice, "price must be equal to kisting price");
        idMarketItem[tokenid].sold=false;
        idMarketItem[tokenid].price=price;
        idMarketItem[tokenid].seller=payable(msg.sender);
        idMarketItem[tokenid].owner=payable(address(this));

        _itemSold.decrement();

        _transfer(msg.sender, address(this), tokenid);

    }

    //create sale

    function createMarketSale(uint256 tokenId) public payable{
        uint256 price= idMarketItem[tokenId].price;
        require(msg.value==price, "Submit asking value");

        idMarketItem[tokenId].owner= payable(msg.sender);
        idMarketItem[tokenId].sold=true;
        idMarketItem[tokenId].owner= payable(address(0));

        _itemSold.increment();
        _transfer(address(this), msg.sender, tokenId);

        payable(owner).transfer(listingprice);
        payable(idMarketItem[tokenId].seller).transfer(msg.value);
    }

    //Unsold NFTs Data

    function UnSold() public view returns(MarketItem[] memory){
        uint itemCount= _tokenIds.current();
        uint unsoldItem= _tokenIds.current() - _itemSold.current();
        uint256 index=0;
        MarketItem[] memory items= new MarketItem[](unsoldItem);
        for(uint256 i=0; i<itemCount; i++){
            if (idMarketItem[i+1].owner==address(this)){
                uint256 currentid=i+1;   
                MarketItem storage currentitem= idMarketItem[currentid];
                items[index]=currentitem;
                index++;
            }
        }
        return items;
    }

    //purchase item

    function fetchNFt() public view returns(MarketItem[] memory){
        uint256 totalcount= _tokenIds.current();
        uint itemcount=0;
        uint index=0;

        for(uint i=0;i<totalcount;i++){
            if(idMarketItem[i+1].owner==msg.sender){
                itemcount++;
            }
        }
        MarketItem[] memory items= new MarketItem[](itemcount);
        for(uint i=0; i<totalcount; i++){
            if(idMarketItem[i+1].owner==msg.sender){
                uint currentid=i+1;
            MarketItem storage currentitem= idMarketItem[currentid];
            items[index]=currentitem;
            index++;
            }
            
        }
        return items;
    }

    //singlr user item

    function single() public view returns(MarketItem[] memory) {
    uint totalcount = _tokenIds.current();
    uint itemcount = 0;

    // First pass: count the matching items
    for (uint i = 0; i < totalcount; i++) {
        if (idMarketItem[i + 1].seller == msg.sender) {
            itemcount++;
        }
    }

    // Second pass: allocate array and store matching items
    MarketItem[] memory items = new MarketItem[](itemcount);
    uint index = 0;
    for (uint i = 0; i < totalcount; i++) {
        if (idMarketItem[i + 1].seller == msg.sender) {
            uint currentId = i + 1;
            MarketItem storage currentitem = idMarketItem[currentId];
            items[index] = currentitem;
            index++;
        }
    }

    return items;
}

}