import 'package:flutter/material.dart';
import 'package:sarthakgupta_api_integration/FirstPage.dart';
void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: FirstPage()
      ),
    );
  }
}
