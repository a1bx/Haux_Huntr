// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ProductAuthentication {
  // Owner of the contract
  address public owner;

  // Event to be emitted when a product is registered
  event ProductRegistered(uint256 productId, address manufacturer, string name, string url, uint256 price);

  // Event to be emitted when a product is verified
  event ProductVerified(uint256 productId, bool isAuthentic);

  // Struct to store product details
  struct Product {
    uint256 id;
    address manufacturer;
    string name;
    string url;
    uint256 price;
    string qrCode;
    bool exists;
  }

  // Mapping to store products by their ID
  mapping(uint256 => Product) private products;

  // Modifier to restrict access to the contract owner
  modifier onlyOwner() {
    require(msg.sender == owner, "Only the owner can perform this action");
    _;
  }

  // Modifier to restrict access to the product manufacturer
  modifier onlyManufacturer(uint256 productId) {
    require(products[productId].manufacturer == msg.sender, "Only the manufacturer can perform this action");
    _;
  }

  // Constructor to set the contract owner
  constructor() {
    owner = msg.sender;
  }

  // Function to register a new product
  function registerProduct(
    uint256 productId,
    string memory name,
    string memory url,
    uint256 price,
    string memory qrCode
  ) public {
    require(!products[productId].exists, "Product already registered");

    products[productId] = Product({
      id: productId,
      manufacturer: msg.sender,
      name: name,
      url: url,
      price: price,
      qrCode: qrCode,
      exists: true
    });

    emit ProductRegistered(productId, msg.sender, name, url, price);
  }

  // Function to verify the authenticity of a product
  function verifyProduct(uint256 productId, string memory scannedQrCode) public view returns (bool, string memory, string memory, uint256) {
    require(products[productId].exists, "Product not registered");

    bool isAuthentic = keccak256(abi.encodePacked(products[productId].qrCode)) == keccak256(abi.encodePacked(scannedQrCode));
    if (isAuthentic) {
      return (true, products[productId].name, products[productId].url, products[productId].price);
    } else {
      return (false, "", "", 0);
    }
  }

  // Function to get product details
  function getProduct(uint256 productId) public view returns (uint256, address, string memory, string memory, uint256) {
    require(products[productId].exists, "Product not registered");

    Product memory product = products[productId];
    return (product.id, product.manufacturer, product.name, product.url, product.price);
  }
}
