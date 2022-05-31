import 'package:flutter/material.dart';

class AboutUsSscreen extends StatelessWidget {
  const AboutUsSscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text("About Us"),
      ),
      body: SizedBox(
        height: h,
        width: w,
        child: Stack(
          children: [
            Container(
              height: h,
              width: w,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                          Colors.white.withOpacity(0.1), BlendMode.dstATop),
                      image: const AssetImage("assets/images/about_bg.jpeg"))),
            ),
            Center(
                child: SizedBox(
              height: h * 0.5,
              width: w * 0.85,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "~> All English Stories at one place in different categories. Read offline.",
                    style: TextStyle(fontFamily: "Roboto", fontSize: 20),
                    textScaleFactor: 0.85,
                  ),
                  SizedBox(
                    height: h * 0.02,
                  ),
                  const Text(
                    "~> This app speaks to us daily with good stories allowing us to share and enrich the world with a collaborative experience.",
                    style: TextStyle(fontSize: 20),
                    textScaleFactor: 0.85,
                  ),
                  SizedBox(
                    height: h * 0.02,
                  ),
                  const Text(
                    "~> 1000 English Stories with Big Ideas. Stories in English to improve your vocabulary and speaking skills. Here is a large collection of Moral Stories.",
                    style: TextStyle(fontSize: 20),
                    textScaleFactor: 0.85,
                  ),
                  SizedBox(
                    height: h * 0.02,
                  ),
                  const Text(
                    "~> Share this app with your friends and have a good time!",
                    style: TextStyle(fontSize: 20),
                    textScaleFactor: 0.85,
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
