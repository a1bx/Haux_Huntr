pragma solidity ^0.8.0;

contract ProductVerifier {
    struct Product {
        uint256 id;
        string qrCode; // Store QR code URI
        bool exists; // Flag to check product existence
    }

    mapping(uint256 => Product) public products;

    event ProductVerified(uint256 indexed id, bool isGenuine); //product exists

    function verifyProduct(uint256 _productId, string memory _scannedQRCode) external view returns (bool) {
        require(products[_productId].exists, "Product does not exist");
        return (keccak256(abi.encodePacked(products[_productId].qrCode)) == keccak256(abi.encodePacked(_scannedQRCode)));
    }
}

