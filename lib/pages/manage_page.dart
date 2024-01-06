import 'package:flutter/material.dart';

class ManagePage extends StatefulWidget {
  const ManagePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<ManagePage> createState() => _ManagePage();
}

class _ManagePage extends State<ManagePage> {

  @override
  Widget build(BuildContext) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title), centerTitle: true,),
      body: Container(),
    );
  }
}