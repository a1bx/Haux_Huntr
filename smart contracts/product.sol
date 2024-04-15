pragma solidity ^0.8.0;

contract ProductRegistry {
    struct Product {
        uint256 id;
        string name;
        string description;
        address owner;
        string qrCode;
        bool exists;
    }

    mapping(uint256 => Product) public products;
    uint256 public productCount;

    address public admin; // Contract admin address

    event ProductCreated(uint256 indexed id, string name, string description, address owner);
    event QRCodeGenerated(uint256 indexed id, string qrCode);

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin");
        _;
    }

    modifier onlyProductOwner(uint256 _productId) {
        require(products[_productId].exists, "Product does not exist");
        require(products[_productId].owner == msg.sender, "You are not the owner of this product");
        _;
    }

    constructor() {
        admin = msg.sender;
    }

    function createProduct(string memory _name, string memory _description) external {
        productCount++;
        products[productCount] = Product(productCount, _name, _description, msg.sender, "", true);

        emit ProductCreated(productCount, _name, _description, msg.sender);
    }

    function generateQRCode(uint256 _productId, string memory _qrCodeURI) external onlyProductOwner(_productId) {
        // Integrate with off-chain QR code generation service
        // For demonstration, I will simply store the QR code URI in the contract
        products[_productId].qrCode = _qrCodeURI;
        emit QRCodeGenerated(_productId, _qrCodeURI);
    }

    function setAdmin(address _admin) external onlyAdmin {
        admin = _admin;
    }
}
