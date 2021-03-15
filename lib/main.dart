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
      // initialRoute: '/',
      // routes: {
      //'/second': (context) => Module(),
      // },
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
                              mail: datas[0]["data"][index]["email"].toString(),
                            ),
                          ),
                        );
                      },
                      title: Text(
                          datas[0]["data"][index]["first_name"].toString()),
                      subtitle:
                          Text(datas[0]["data"][index]["last_name"].toString()),
                    )
                  ],
                ),
              ),
      ),
    );
  }

  Future getIslemiYap() async {
    // Respawn is like => {"page":2,"per_page":6,"total":12,"total_pages":2,"data":[{"id":7,"email":"michael.lawson@reqres.in","first_name":"Michael","last_name":"Lawson","avatar":"https://reqres.in/img/faces/7-image.jpg"},{"id":8,"email":"lindsay.ferguson@reqres.in","first_name":"Lindsay","last_name":"Ferguson","avatar":"https://reqres.in/img/faces/8-image.jpg"},{"id":9,"email":"tobias.funke@reqres.in","first_name":"Tobias","last_name":"Funke","avatar":"https://reqres.in/img/faces/9-image.jpg"},{"id":10,"email":"byron.fields@reqres.in","first_name":"Byron","last_name":"Fields","avatar":"https://reqres.in/img/faces/10-image.jpg"},{"id":11,"email":"george.edwards@reqres.in","first_name":"George","last_name":"Edwards","avatar":"https://reqres.in/img/faces/11-image.jpg"},{"id":12,"email":"rachel.howell@reqres.in","first_name":"Rachel","last_name":"Howell","avatar":"https://reqres.in/img/faces/12-image.jpg"}],"support":{"url":"https://reqres.in/#support-heading","text":"To keep ReqRes free, contributions towards server costs are appreciated!"}}
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
          // print(datas);
          loading = true;
        });
      }
    } else {
      print("hata");
    }
  }
}
