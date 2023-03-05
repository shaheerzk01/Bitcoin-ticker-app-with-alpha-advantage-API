import 'package:http/http.dart' as http;
import 'dart:convert' as json;

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
  'ZAR',
  'PKR',
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const apikey = 'JOJG6NHIY5T4LJGU';
const Url = 'https://www.alphavantage.co/query?function=CURRENCY_EXCHANGE_RATE&from_currency';

class CoinData {

  Future getData(String selectedcurrency) async{

    Map<String,String> cryptoPrices ={};
    for(String crypto in cryptoList){
      String requestUrl = '$Url=$crypto&to_currency=$selectedcurrency&apikey=$apikey';
      http.Response response = await http.get(requestUrl);
      if(response.statusCode==200){
        var decodedData = json.jsonDecode(response.body);
        dynamic lastPrice = decodedData['Realtime Currency Exchange Rate']['9. Ask Price'];
        cryptoPrices[crypto] = lastPrice.toString();
      }else{
        print(response.statusCode);
        throw 'Problem with the request get';
      }
    }
    return cryptoPrices;
  }
}
