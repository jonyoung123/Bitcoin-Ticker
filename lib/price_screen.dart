import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {

  String selectedValue = 'USD';
  late CoinData coinData = CoinData();
  int currentIndex = 0;

  Map<String, String> coinValues = {};
  bool isWaiting = false;


  Widget androidDropDown (){
    List<DropdownMenuItem<String>> currencyList =  [];
    for (var element in currenciesList) {
      currencyList.add(
          DropdownMenuItem(
            value: element,
            child: Text(element),)
      );
    }
    return DropdownButton<String>(
      value: selectedValue,
      items: currencyList,
      onChanged:
            (newValue){
          setState((){
            selectedValue = newValue!;
            updateUI();
          });
        },
    );
  }

  CupertinoPicker iosPicker(){
    List<Text> iosCurrencyList = [];
    for (String value in currenciesList) {
      iosCurrencyList.add(
          Text(value)
      );
    }
    return CupertinoPicker(itemExtent: 40.0,
        onSelectedItemChanged: (currentIndex){
          setState((){
            selectedValue = currenciesList[currentIndex];
            updateUI();
          });
        },
        children: iosCurrencyList);
  }

  @override
  void initState(){
    super.initState();
    updateUI();
  }
  Future updateUI() async{
    isWaiting = true;
    try{
      var cryptoData = await coinData.getCoinData(selectedValue);
      isWaiting = false;
      setState(() {
        coinValues = cryptoData;
      });
    } catch(e){
      return e;
    }
  }
  List<Widget> makeCards() {
    List<Widget> cryptoCards = [];
    for (var crypto in cryptoList) {
      cryptoCards.add(
          CryptoCard(selectedCurrency: selectedValue,
              marketRate: isWaiting? '??' : coinValues[crypto],
              crypto: crypto)
      );
    }
    return cryptoCards;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: makeCards(),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: (Platform.isIOS) ? iosPicker() : androidDropDown()
          ),
        ],
      ),
    );
  }
}


