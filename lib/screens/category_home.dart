import 'package:englishstories/ad_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:englishstories/constant_veriable.dart';
import 'package:englishstories/notification.dart';
import 'package:englishstories/widgets/catagory_home_show_category_container_widget.dart';

import 'about_screen.dart';
import 'bookmark_screen.dart';

class CategoryHome extends StatefulWidget {
  const CategoryHome({Key? key}) : super(key: key);

  @override
  State<CategoryHome> createState() => _CategoryHomeState();
}

class _CategoryHomeState extends State<CategoryHome> {
  DateTime? lastPressed;

  launchEmail() async {
    const url =
        "mailto:jeelbhatti.9brainz@gmail.com&subject=English Stories Contact Us&body=Hello Mr/Mrs \n";

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Fluttertoast.showToast(msg: "Error To send Message");
    }
  }

  getDb() async {
    await dbHelper.databaseGet();
    setState(() {});
  }

  final myBanner =
      MobileAdsModel().getBannerAd('ca-app-pub-5457223538074902/2512718702');
  @override
  void initState() {
    getDb();
    myBanner.load();
    Provider.of<NotificationService>(context, listen: false).initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        final now = DateTime.now();
        const maxDuration = Duration(seconds: 2);
        final isWarning =
            lastPressed == null || now.difference(lastPressed!) > maxDuration;

        if (isWarning) {
          lastPressed = DateTime.now();
          Fluttertoast.showToast(msg: "Double click to exit app");
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          title: const Text("Stories"),
        ),
        drawer: Drawer(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              Image.asset(
                "assets/images/bg_intro.jpg",
                fit: BoxFit.fill,
                height: MediaQuery.of(context).size.height * 0.23,
              ),
              const SizedBox(
                height: 10,
              ),
              ListTile(
                tileColor: context.theme.highlightColor,
                title: Row(
                  children: [
                    Icon(
                      CupertinoIcons.home,
                      color: context.theme.iconTheme.color,
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    const Text('Home'),
                  ],
                ),
                onTap: () {
                  Get.back();
                },
              ),
              ListTile(
                title: Row(
                  children: [
                    Icon(
                      CupertinoIcons.bookmark_solid,
                      color: context.theme.iconTheme.color,
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    const Text('Bookmarks'),
                  ],
                ),
                onTap: () {
                  Get.back();
                  Get.to(() => const BookMarkScreen());
                },
              ),
              const Divider(
                thickness: 1.3,
              ),
              Container(
                  padding: const EdgeInsets.only(left: 15),
                  child: const Text(
                    "Settings",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  )),
              ValueListenableBuilder(
                  valueListenable: isDarkMode,
                  builder: (context, c, v) {
                    return ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Dark Mode'),
                          SizedBox(
                            width: w * 0.1,
                            height: 30,
                            child: CupertinoSwitch(
                              value: isDarkMode.value,
                              onChanged: (v) async {
                                isDarkMode.value = v;
                                SharedPreferences preferences =
                                    await SharedPreferences.getInstance();
                                if (isDarkMode.value) {
                                  preferences.setBool("isDarkMode", v);
                                  Get.changeTheme(ThemeData.dark());
                                } else {
                                  preferences.setBool("isDarkMode", v);
                                  Get.changeTheme(ThemeData.light());
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        Get.back();
                      },
                    );
                  }),
              Consumer<NotificationService>(
                builder: (context, model, v) {
                  return ValueListenableBuilder(
                      valueListenable: isDailyNotification,
                      builder: (context, c, v) {
                        return ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Daily Notification'),
                              SizedBox(
                                width: w * 0.1,
                                height: 30,
                                child: CupertinoSwitch(
                                  value: isDailyNotification.value,
                                  onChanged: (v) async {
                                    SharedPreferences preferences =
                                        await SharedPreferences.getInstance();
                                    preferences.setBool("isNotificationON", v);
                                    isDailyNotification.value = v;
                                    if (v == true) {
                                      model.sheduledNotification();
                                    } else {
                                      model.cancelNotification();
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                          onTap: () {
                            Get.back();
                          },
                        );
                      });
                },
              ),
              const Divider(
                thickness: 1.3,
              ),
              Container(
                  padding: const EdgeInsets.only(left: 15),
                  child: const Text(
                    "More",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  )),
              ListTile(
                title: Row(
                  children: [
                    Icon(
                      CupertinoIcons.star_fill,
                      color: context.theme.iconTheme.color,
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    const Text('Rate App'),
                  ],
                ),
                onTap: () {
                  Get.back();
                },
              ),
              ListTile(
                title: Row(
                  children: [
                    Icon(
                      CupertinoIcons.share,
                      color: context.theme.iconTheme.color,
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    const Text('Share App'),
                  ],
                ),
                onTap: () {
                  Get.back();
                },
              ),
              ListTile(
                title: Row(
                  children: [
                    Icon(
                      CupertinoIcons.info,
                      color: context.theme.iconTheme.color,
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    const Text('About Us'),
                  ],
                ),
                onTap: () {
                  Get.to(() => const AboutUsSscreen());
                },
              ),
              ListTile(
                title: Row(
                  children: [
                    Icon(
                      CupertinoIcons.phone,
                      color: context.theme.iconTheme.color,
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    const Text('Contact Us'),
                  ],
                ),
                onTap: () async {
                  await launchEmail();
                },
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.8 - 5,
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 10, bottom: 10),
              child: SizedBox(
                child: ListView.builder(
                  itemCount: dbHelper.remedieTypeDataList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) => ShowCategoryContainerWidget(
                    subCategoryID: (index + 1).toString(),
                    categoryName:
                        "${dbHelper.remedieTypeDataList[index]['REMEDIE_NAME']}",
                    imageName:
                        "assets/images/${dbHelper.remedieTypeDataList[index]['IMAGE_NAME']}.png",
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 60,
              width: w,
              child: AdWidget(ad: myBanner),
            ),
          ],
        ),
      ),
    );
  }
}
