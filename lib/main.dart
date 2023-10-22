import 'package:flutter/material.dart';
import 'package:iml_practical/ui/home/home_view.dart';
import 'package:iml_practical/ui/home/home_view_model.dart';
import 'package:iml_practical/utils/common_colors.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => HomeViewModel()),
  ], child: const MyApp()));
}

GlobalKey<NavigatorState> mainNavKey = GlobalKey();

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: CommonColors.primaryColor),
        useMaterial3: true,
      ),
      home: const HomeView(),
    );
  }
}
