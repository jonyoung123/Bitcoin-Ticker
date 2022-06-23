import 'package:flutter/material.dart';
import 'package:bitcoin_ticker/network.dart';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];


class CoinData {

  String apiKey = '500A4FB6-CC40-41A6-BBA7-9E0A2402F338';
  String apiKey1 = '11F4495F-9900-4B01-92C8-B25D3FA4ABAC';
  String myAPIKey = '77804116-9DC1-41A1-927E-93FB3F30737E';
  String coinSite = 'https://rest.coinapi.io/v1/exchangerate';
  String marketRate  = '??';

  Future getCoinData(String selectedCurrency) async{
    Map<String, String> cryptoCurrency = {};
    for (var value in cryptoList) {
      NetworkHelper networkHelper = NetworkHelper('$coinSite/$value/$selectedCurrency?apikey=$apiKey1');
      var decodedData = await networkHelper.getData();
      if (decodedData==null){
        marketRate = '??';
      }
      double rate = decodedData["rate"];
      marketRate = rate.toStringAsFixed(0);
      cryptoCurrency[value] = marketRate;
    }
    return cryptoCurrency;
  }

}

class CryptoCard extends StatelessWidget {
  final String selectedCurrency;
  final String crypto;
  final String? marketRate;
  CryptoCard({required this.selectedCurrency, required this.marketRate, required this.crypto});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 18, right: 18, top: 18),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $crypto = $marketRate $selectedCurrency',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}



// ALTERNATIVE getCurrencyList()
// items: currenciesList.map<DropdownMenuItem<String>>((String value){
//   return DropdownMenuItem(
//       child: Text(value),
//   value: value,);
// }).toList(),
