import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:quotes/Providers/FavoritesProvider.dart';
import 'package:quotes/Providers/PageProvider.dart';
import 'package:quotes/Providers/QuotesProvider.dart';
import 'package:quotes/Screens/Home.dart';
import 'package:quotes/providers/SearchQueryProvider.dart';

import 'Model/QuoteModel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(QuoteAdapter());
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => FavoritesProvider()),
      ChangeNotifierProvider(create: (_) => PageProvider()),
      ChangeNotifierProvider(create: (_) => QuotesProvider()),
      ChangeNotifierProvider(create: (_) => SearchQueryProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<PageProvider>(context, listen: true).currentPage;
    return MaterialApp(
      // showPerformanceOverlay: true,
      // showSemanticsDebugger: true,
      // debugShowMaterialGrid: false,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
    );
  }
}
