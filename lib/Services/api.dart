import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiClient{
  final Uri currencyUrl = Uri.https("free.currconv.com", "/api/v7/currencies", {"apiKey": "6622d8c9161cb06cfa46"});

  Future<List<String>> getCurrencies() async{
    http.Response res = await http.get(currencyUrl);
    if(res.statusCode == 200){
      var body = jsonDecode(res.body);
      var list = body["results"];
      List<String> currencies = (list.keys).toList();
      print(currencies); 
      return currencies;
    }else{
      throw Exception("Failed to connect to Api");
    }
  }

  Future<double> getRate (String from , String to) async{
    final Uri rateUrl = Uri.https("free.currconv.com", "/api/v7/convert",{
      "apiKey": "6622d8c9161cb06cfa46",
      "q": "${from}_${to}",
      "compact": "ultra"
      });
      http.Response res = await http.get(rateUrl);
      if(res.statusCode == 200){
        var body = jsonDecode(res.body);
        return body["${from}_${to}"];
      }else{
        throw Exception("Failed to connect Api");
      }
  }

}