import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';

class Module extends StatefulWidget {
  const Module({
    Key key,
    @required this.mail,
  }) : super(key: key);

  final String mail;
  @override
  _ModuleState createState() => _ModuleState();
}

class _ModuleState extends State<Module> {
  bool loading = false;
  String name = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Title"),
      ),
      body: Column(
        children: [
          ListTile(
            onTap: () {
              postIslemiYap();
            },
            title: Text(widget.mail),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (val) {
                setState(() {
                  name = val;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(name),
          )
        ],
      ),
    );
  }

  Future postIslemiYap() async {
    String url = "https://reqres.in/api/users";
    var body = jsonEncode({"name": name, "job": "leader"});
    var response = await http.post(url, body: body);
    // print(response.statusCode);
    if (response.statusCode == 201) {
      if (this.mounted) {
        print(body);
        print(jsonDecode(response.body));
        //Respawn is like => {id: 4, createdAt: 2021-03-15T10:03:51.663Z}
      }
    } else {
      print("hata");
    }
  }
}
