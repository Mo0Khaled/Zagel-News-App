import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

/// [main] is the entry point for Flutter applications.
Future<void> main() async {
  final appDocumentDir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocumentDir.path);
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
