import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'module.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool loading = false;
  List datas = [];

  @override
  void initState() {
    getIslemiYap();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: '/',
        routes: {
          // When navigating to the "/" route, build the FirstScreen widget.

          // When navigating to the "/second" route, build the SecondScreen widget.
          //'/second': (context) => Module(),
        },
        home: Scaffold(
          body: loading == false
              ? Center(
                  child: SingleChildScrollView(),
                )
              : ListView.builder(
                  itemCount: datas[0]["data"].length,
                  itemBuilder: (BuildContext context, int index) => Column(
                        children: [
                          ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Module(
                                    mail: datas[0]["data"][index]["email"]
                                        .toString(),
                                  ),
                                ),
                              );
                            },
                            title: Text(datas[0]["data"][index]["first_name"]
                                .toString()),
                            subtitle: Text(datas[0]["data"][index]["last_name"]
                                .toString()),
                          )
                          // Text(datas[index]["data"].toString()),
                          // Text(datas[index]["support"].toString())
                        ],
                      )),
        ));
  }

  Future getIslemiYap() async {
    setState(() {
      loading = false;
    });
    String url = "https://reqres.in/api/users?page=2";
    var response = await http.get(url);
    // print(response.statusCode);
    if (response.statusCode == 200) {
      if (this.mounted) {
        setState(() {
          datas.add(json.decode(response.body));
          print(datas);
          loading = true;
        });
      }
    } else {
      print("hata");
    }
    //print(await http.read('https://example.com/foobar.txt'));
  }
}
