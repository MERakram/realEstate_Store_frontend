import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'main3.dart';

void main() {
  runApp(MaterialApp( home : hello(),
    debugShowCheckedModeBanner: false,
  ),);

}

class networking{
  networking(this.url);
  final String url;

  Future<void> getData() async{
    var urli = Uri.parse(url);
    http.Response response = await http.get(urli);
    if (response.statusCode==200){
      print(response.body);
    }else
      print('error : ${response.statusCode}');

  }
}
class hello extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(backgroundColor: Colors.grey,
        body: Center(
          child: ElevatedButton(
              child: Text("ElevatedButton"),
              onPressed: () async {
                networking getUrl = networking('http://127.0.0.1:8000/mem/product/');
                 await getUrl.getData();
              }),
        ),
      ),
    );
  }
}
