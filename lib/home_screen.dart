import 'package:currency_converter_app/Services/api.dart';
import 'package:currency_converter_app/Widgets/drop_down.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  ApiClient client = ApiClient();
  
  Color mainColor = const Color(0xff212936);
  Color secondColor = const Color(0xff2849e5);
  List<String> currencies = [''];
  String from = 'USD';
  String to = '';

  double? rate;
  String result = '';
  
  Future<List<String>> getCurrencyList() async {
    return await client.getCurrencies();
  }

  @override
  void initState() {
    super.initState();
    (() async {
      List <String> list = await client.getCurrencies();
      setState(() {
        currencies = list;
      });
    })();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 200,
                child: const Text(
                  "Currency Converter",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Expanded(child: Center(child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextField(
                    onSubmitted: (value) async{
                      rate = await client.getRate(from, to);
                      setState(() {
                        result = (rate! * double.parse(value)).toStringAsFixed(3);
                      });
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: "Input value to convert",
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 18,
                        color: secondColor
                      )
                    ),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold
                    ),
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      customDropDown(currencies, from, (val) {
                        setState(() {
                          from = val;
                        });
                       }),
                       FloatingActionButton(onPressed: (){
                        String temp = from;
                        setState(() {
                          from = to;
                          to = temp;
                        });
                       }, child: Icon(Icons.swap_horiz, color: Colors.white,), elevation: 0, backgroundColor: secondColor,),
                       customDropDown(currencies, to, (val) { 
                        setState(() {
                          to = val;
                        });
                       })

                    ],
                  ),
                  const SizedBox(height: 50,),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16)
                    ),
                    child: Column(
                      children: [
                        const Text('Result', style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),),
                        Text(result, style: TextStyle(color: secondColor, fontSize: 36, fontWeight: FontWeight.bold),)
                      ],
                    ),
                  )
                ],
              ),))
            ],
          ),
          )),
    );
  }
}