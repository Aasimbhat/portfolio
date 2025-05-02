import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'screens/portfolio_home.dart';
import 'themes/app_theme.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Portfolio 2025',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.getTheme(),
      home: const PortfolioHome(),
    );
  }
}
