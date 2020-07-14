import 'package:flutter/material.dart';
import 'package:timer_app/settings.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Setting"),),
      body: Container(
        child: Settings() ,
      ),
    );
  }
}
