import 'package:flutter/material.dart';

/// [main] is the entry point for Flutter applications.
void main() {
  runApp(const ZagelNewsApp());
}

/// A Widget that displays the ZagelNewsApp.
class ZagelNewsApp extends StatelessWidget {
  const ZagelNewsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zagel News',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: const ,
    );
  }
}
