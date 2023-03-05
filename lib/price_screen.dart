import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'coin_dart.dart';
import 'dart:io' show Platform;




class priceScreen extends StatefulWidget {
  const priceScreen({Key? key}) : super(key: key);

  @override
  State<priceScreen> createState() => _priceScreenState();
}

class _priceScreenState extends State<priceScreen> {
  String? selectedCurrency = 'AUD';
  dynamic bitcoinValue;


  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropDownitem = [];
    for (String items in currenciesList) {
      String currency = items;
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropDownitem.add(newItem);
    }
    return DropdownButton<String>(
      elevation: 5,
      borderRadius: BorderRadius.circular(10),
      dropdownColor: Colors.indigo,
      style: TextStyle(fontSize: 25),
      value: selectedCurrency,
      items: dropDownitem,
      onChanged: (value) {
        setState(
          () {
            selectedCurrency = value;
            getData();
          },
        );
      },
    );
  }

  CupertinoPicker IOSpicker(){

    List<Text> pickeritems = [];
    for (String items in currenciesList) {
      pickeritems.add(Text(items));
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        print(selectedIndex);
        setState(() {
          selectedCurrency = currenciesList[selectedIndex];
          getData();
        });
      },
      children: pickeritems,
    );
  }

  Map<String,String> coinValues={};
  bool iswaiting = false;


  void getData() async{
    iswaiting = true;
    try{
      CoinData data = CoinData();
      var Data = await data.getData(selectedCurrency.toString());
      iswaiting = false;
      setState(() {
        coinValues = Data;
      });
    }catch(e){
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  Column makeCards(){
    List<CryptoCard> cryptoCards = [];
    for(String crypto in cryptoList){
      cryptoCards.add(
       CryptoCard(
         cryptoCurrency: crypto,
         value: iswaiting ? '?': coinValues[crypto],
         selectedCurrency: selectedCurrency,
       )
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: cryptoCards,
    );
  }


  Widget getPicker(){
    if(Platform.isIOS){
      return IOSpicker();
    }else if(Platform.isAndroid){
      return androidDropdown();
    }else{
      return Text('ERROR');
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('🤑 Coin Ticker'),
        ),
        backgroundColor: Colors.lightBlue,
        elevation: 10,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          makeCards(),
          Container(
            height: 100.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: getPicker(),
          )
        ],
      ),
    );
  }
}

class CryptoCard extends StatelessWidget {

  const CryptoCard({
    this.value,
    this.selectedCurrency,
    this.cryptoCurrency,
  });

  final String? value;
  final String? selectedCurrency;
  final String? cryptoCurrency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 22.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $cryptoCurrency = $value $selectedCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

