import 'package:englishstories/constant_veriable.dart';
import 'package:englishstories/notification.dart';
import 'package:englishstories/screens/category_home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await Firebase.initializeApp();

  // Pass all uncaught errors from the framework to Crashlytics.
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  getUserSettings() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
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
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => NotificationService())
            ],
            child: GetMaterialApp(
              title: 'Stories App',
              theme: isDarkMode.value ? ThemeData.dark() : ThemeData.light(),
              themeMode: isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
              darkTheme: ThemeData.dark(),
              home: const CategoryHome(),
            ),
          );
        });
  }
}
