import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:zagel_news_app/core/theme/app_theme.dart';
import 'package:zagel_news_app/features/news/presentation/pages/home_page.dart';
import 'package:zagel_news_app/injection_container.dart';

import 'features/news/presentation/pages/home_page_river.dart';

/// [main] is the entry point for Flutter applications.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();

  final appDocumentDir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocumentDir.path);
  runApp(const ProviderScope(child: ZagelNewsApp()));
}

/// A Widget that displays the ZagelNewsApp.
class ZagelNewsApp extends StatelessWidget {
  const ZagelNewsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zagel News',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: const HomePageRiver(),
    );
  }
}
