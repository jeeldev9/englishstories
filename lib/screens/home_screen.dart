import 'dart:async';
import 'package:englishstories/constant_veriable.dart';
import 'package:englishstories/screens/category_home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  startTime() async {
    var duration = const Duration(seconds: 4);
    return Timer(duration, route);
  }

  route() {
    Get.offAll(const CategoryHome());
  }

  @override
  void initState() {
    startTime();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SizedBox(
        height: h,
        width: w,
        child: Stack(
          children: [
            SizedBox(
              height: h,
              width: w,
              child: Image.asset(
                "assets/images/splash.png",
                height: h,
                width: w,
                fit: BoxFit.fill,
              ),
            ),
            Positioned(
              left: 20.0,
              right: 20.0,
              bottom: 40.0,
              child: SizedBox(
                width: w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("Loading...",
                        style: TextStyle(fontSize: 18, color: Colors.white)),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: w * 0.8,
                      child: LinearProgressIndicator(
                        color: Colors.red,
                        backgroundColor: Colors.red.shade200,
                        //valueColor:AlwaysStoppedAnimation<Color>(Colors.red) ,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
