
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stream_basic/env/env.dart';

import '../model/datamodel.dart';


class CryptoApiPage extends StatefulWidget {
  const CryptoApiPage({Key? key}) : super(key: key);

  @override
  _CryptoApiPageState createState() => _CryptoApiPageState();
}

class _CryptoApiPageState extends State<CryptoApiPage> {

  //create stream
  StreamController<DataModel> _streamController = StreamController();

  @override
  void dispose() {
    // stop streaming when app close
    _streamController.close();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // A Timer method that run every 3 seconds

    Timer.periodic(Duration(seconds: 3), (timer) {
      getCryptoPrice();
    });

  }

  // a future method that fetch data from API
  Future<void> getCryptoPrice() async{

    var url = Uri.parse('https://api.nomics.com/v1/currencies/ticker?key=$yourAPIKey&ids=BTC');

    final response = await http.get(url);
    final databody = json.decode(response.body).first;

    DataModel dataModel = new DataModel.fromJson(databody);

    // add API response to stream controller sink
    _streamController.sink.add(dataModel);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder<DataModel>(
          stream: _streamController.stream,
          builder: (context,snapshot){
            switch(snapshot.connectionState){
              case ConnectionState.waiting: return Center(child: CircularProgressIndicator(),);
              default: if(snapshot.hasError){
                return Text('Please Wait....');
              }else{
                return BuildCoinWidget(snapshot.data!);
              }
            }
          },
        ),
      ),
    );
  }

  Widget BuildCoinWidget(DataModel dataModel){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('${dataModel.name}',style: TextStyle(fontSize: 25),),
          SizedBox(height: 20,),
          SvgPicture.network('${dataModel.image}',width: 150,height: 150,),
          SizedBox(height: 20,),
          Text('\$${dataModel.price}',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
        ],
      ),
    );
  }
}