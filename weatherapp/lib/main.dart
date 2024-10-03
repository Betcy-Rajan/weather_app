import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weatherapp/screens/home_page.dart';

void main() {
  // final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      theme: ThemeData (
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        )
      ),
      
      home: const HomePage(),
      );
  }
}
