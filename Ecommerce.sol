// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0; 
contract Ecommerce{

    struct product{
        string tittle;
        string description;
        address payable seller;
        uint product_Id;
        uint price;
        address buyer;
        bool delivered;
    }

    product[] public products;
    uint counter=1;
    event register(string tittle ,uint product_id,address seller);
    event buy(uint product_id, address buyer);
    event deliver(uint product_id);

    function product_registration(string memory _tittle, string memory _description, uint _price) public {
        require(_price>0, "Price should be greater then 0");
        product memory tempProducts;
        tempProducts.tittle=_tittle;
        tempProducts.description=_description;
        tempProducts.price=_price*10**18;
        tempProducts.seller=payable (msg.sender);
        tempProducts.product_Id=counter;
        products.push(tempProducts);
        counter++;
        emit register(_tittle,tempProducts.product_Id,msg.sender);

    }

    function Buy(uint Product_Id) payable public{
        require(products[Product_Id-1].price==msg.value, "pay exact price");
        require(products[Product_Id-1].seller!=msg.sender, "You cannot buy this product");
        products[Product_Id-1].buyer=msg.sender;
        emit buy(Product_Id , msg.sender);
    }

    function delivery(uint Product_Id) public {
        require(products[Product_Id-1].buyer==msg.sender,"Only buyer can confirm the delivery");
        products[Product_Id-1].delivered=true;
        products[Product_Id-1].seller.transfer(products[Product_Id].price);
        emit deliver(Product_Id);
    }
}