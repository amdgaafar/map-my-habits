import 'package:flutter/material.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MapPage> createState() => _MapPage();
}

class _MapPage extends State<MapPage> {

  @override
  Widget build(BuildContext) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title), centerTitle: true,),
      body: Container(),
    );
  }
}