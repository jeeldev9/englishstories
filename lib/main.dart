import 'package:englishstories/constant_veriable.dart';
import 'package:englishstories/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  getUserSettings() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    print(preferences.getBool("isDarkMode"));
    isDarkMode.value = preferences.getBool("isDarkMode") ?? false;
    isDailyNotification.value =
        preferences.getBool("isNotificationON") ?? false;
    setState(() {});
  }

  @override
  void initState() {
    getUserSettings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: isDarkMode,
        builder: (context, c, v) {
          return GetMaterialApp(
            title: 'Flutter Demo',
            theme: isDarkMode.value ? ThemeData.dark() : ThemeData.light(),
            themeMode: isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
            darkTheme: ThemeData.dark(),
            home: const HomeScreen(),
          );
        });
  }
}
