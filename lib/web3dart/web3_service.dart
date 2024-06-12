import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

class Web3Service {
  final String _rpcUrl = 'http://127.0.0.1:7545';
  final String _privateKey = '0xecb5b71d0844aa9562f16cd081a89c93109e34497c788895450617691bc2f9ba';
  final String _contractAddress = '5777';

  late Web3Client _client;
  late DeployedContract _contract;
  late ContractFunction _registerProduct;
  late ContractFunction _verifyProduct;

  Web3Service() {
    _client = Web3Client(_rpcUrl, Client());
    _initializeContract();
  }

  Future<void> _initializeContract() async {
    String abiCode = await rootBundle.loadString('assets/abi.json');
    _contract = DeployedContract(
      ContractAbi.fromJson(abiCode, 'ProductAuthentication'),
      EthereumAddress.fromHex(_contractAddress),
    );

    _registerProduct = _contract.function('registerProduct');
    _verifyProduct = _contract.function('verifyProduct');
  }

  Future<String> scanAndVerifyProduct(String qrCode) async {
    var result = await _client.call(
      contract: _contract,
      function: _verifyProduct,
      params: [qrCode],
    );

    bool isAuthentic = result[0];
    String name = result[1];
    String url = result[2];
    int price = result[3];

    if (isAuthentic) {
      return 'Product is Authentic\nName: $name\nURL: $url\nPrice: $price';
    } else {
      return 'Product is Fake';
    }
  }
}
