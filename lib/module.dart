import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ASDKJL"),
      ),
      body: Column(
        children: [Text(widget.mail), TextField()],
      ),
    );
  }
}
