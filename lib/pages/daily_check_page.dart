import 'package:flutter/material.dart';

class DailyCheckPage extends StatefulWidget {
  const DailyCheckPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  // _DailyCheckPageState createState() => _DailyCheckPageState();
  State<DailyCheckPage> createState() => _DailyCheckPageState();  
}

class _DailyCheckPageState extends State<DailyCheckPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title), centerTitle: true),
      body: Container(),
    );
  }
}