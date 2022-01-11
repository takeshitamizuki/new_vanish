import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("あああああ"),
        backgroundColor: Colors.green,
      ),
    );
  }
  late Map data;
  late List userData;

  Future getData() async {
    //Future xxx async{} という記法
    http.Response response = await http.get(
        "https://reqres.in/api/users?page=2");
    data = json.decode(response.body); //json->Mapオブジェクトに格納
    setState(() { //状態が変化した場合によばれる
      userData = data["data"]; //Map->Listに必要な情報だけ格納
    });
  }
}