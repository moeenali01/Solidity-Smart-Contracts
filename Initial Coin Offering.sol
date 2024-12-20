// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

interface ERC{
    function transfer( address _to, uint256 _value) external returns(bool);
    function transferFrom(address _from, address _to, uint256 _value) external returns(bool);
    function approve(address spender, uint256 value) external returns(bool);
    function allowance(address owner, address spender) external returns(uint256);
    function balanceOf(address account) external view returns (uint256);
    function symbol() external view returns (string memory);
    function totalSupply() external view returns (uint256);
    function name() external view returns (string memory);

}

contract ICO{
    address public owner;
    address public TokenAddress;
    uint public TokenPrice;
    uint public TokenSold;

    constructor(){
        owner=msg.sender;
    }

    modifier onlyOwner(){
        require(msg.sender == owner);
        _;
    }

    function updateToken(address _TokenAddress) public onlyOwner{
        TokenAddress = _TokenAddress;
    }

    function updateTokenPrice(uint _TokenPrice) public onlyOwner{
        TokenPrice = _TokenPrice;
    }

    function multiply(uint x,uint y) internal pure returns(uint z){
     require(y == 0 || ((z = x * y) / y) == x);    
    }
    

    function BuyToken(uint amount) public payable {
        require(msg.value == multiply(TokenPrice,amount), "Not Enough Ethers");
        ERC token= ERC(TokenAddress);
        require(amount<=token.balanceOf(msg.sender), "Not Enough Token");
        require(token.transfer(msg.sender,amount*1e18));
        payable(owner).transfer(msg.value);
        TokenSold += amount;
    }           

    function TokenDetails() public view returns(string memory name,string memory symbol,uint balance,uint totalSupply,uint price,address tokenAddress){
        ERC token= ERC(TokenAddress);
        return(token.name(),token.symbol(),token.balanceOf(address(this)),token.totalSupply(),TokenPrice,TokenAddress);
        
    }

    function TransfertoOwner(uint amount) external payable {
        require(msg.value>=amount, "Insufficient funds");
        (bool success, )=owner.call{value:amount}("");
        require(success,"Transfer failed");
    }

    function TransferEther(address to, uint amount) external payable {
        require(msg.value>=amount, "Insufficient funds");
        (bool success, )=to.call{value:amount}("");
        require(success,"Transfer failed");
    }

    function WithdrawTokens() public onlyOwner{
        ERC token= ERC(TokenAddress);
        uint balance=token.balanceOf(address(this));
        require(balance>0,"Nothing to withdraw");
        token.transfer(owner,token.balanceOf(address(this)));
    }


}  
