import 'package:englishstories/constant_veriable.dart';
import 'package:englishstories/screens/bookmark_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:share/share.dart';


// ignore: must_be_immutable
class ReadBookmarkStory extends StatefulWidget {
  String title;
  String description;

  ReadBookmarkStory({Key? key, required this.title, required this.description}) : super(key: key);

  @override
  _ReadBookmarkStoryState createState() => _ReadBookmarkStoryState();
}

class _ReadBookmarkStoryState extends State<ReadBookmarkStory> {
  late int indexOfTitle;
  late ScrollController controller;
  late ValueNotifier<bool> isExpanded = ValueNotifier(true);

  @override
  void initState() {
    bool isContain = false;
    for (int i = 0; i < dbHelper.bookmarkList.value.length; i++) {
      if (widget.title == dbHelper.bookmarkList.value[i]['title']) {
        isContain = true;
      }
    }
    //If not contain in list them add
    if (isContain == true) {
      isBookmarked.value = true;
    } else {
      isBookmarked.value = false;
    }
    controller = ScrollController()
      ..addListener(() {
        if (controller.hasClients &&
            controller.offset > (120 - kToolbarHeight)) {
          isExpanded.value = false;
        } else {
          isExpanded.value = true;
        }
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.teal,
      body: SafeArea(
        top: false,
        child: CustomScrollView(
          controller: controller,
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              pinned: true,
              snap: false,
              floating: true,
              
              expandedHeight: 160.0,
              actions: [
                ValueListenableBuilder(
                    valueListenable: isExpanded,
                    builder: (context, c, v) {
                      return isExpanded.value
                          ? Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    // Get.to();
                                    isDarkMode.value = !isDarkMode.value;
                                    if (isDarkMode.value) {
                                      Get.changeTheme(ThemeData.dark());
                                    } else {
                                      Get.changeTheme(ThemeData.light());
                                    }
                                  },
                                  child: ValueListenableBuilder(
                                    valueListenable: isDarkMode,
                                    builder: (context, c, v) {
                                      return isDarkMode.value
                                          ? Image.asset(
                                              "assets/icons/icons8-full-moon-96.png",
                                              height: 35,
                                              width: 35,
                                            )
                                          : Image.asset(
                                              "assets/icons/icons8-sun-96.png",
                                              height: 35,
                                              width: 35,
                                            );
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.to(() => const BookMarkScreen());
                                  },
                                  child: const Icon(
                                    Icons.book_outlined,
                                    size: 28,
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    bool isContain = false;

                                    for (int i = 0;
                                        i < dbHelper.bookmarkList.value.length;
                                        i++) {
                                      if (widget.title ==
                                          dbHelper.bookmarkList.value[i]
                                              ['title']) {
                                        isContain = true;
                                        indexOfTitle = i;
                                      }
                                    }
                                    //If not contain in list them add
                                    if (isContain == false) {
                                      isBookmarked.value = true;
                                      //Add title and description in List
                                      // dbHelper.bookmarkList.value.add({
                                      //   "title":widget.title,
                                      //   "description":widget.description,
                                      // });
                                      //store Bookmark in database

                                      dbHelper.insertDataIntoDB(
                                          widget.title, widget.description);
                                    } else {
                                      //if already added to list then remove
                                      isBookmarked.value = false;

                                      dbHelper.deleteDataIntoDB(dbHelper
                                          .bookmarkList
                                          .value[indexOfTitle]['id']
                                          .toString());
                                    }
                                  },
                                  child: ValueListenableBuilder(
                                    valueListenable: isBookmarked,
                                    builder: (context, v, c) {
                                      return isBookmarked.value
                                          ? const Icon(
                                              CupertinoIcons.bookmark_solid,
                                              size: 28,
                                              color: Colors.red,
                                            )
                                          : const Icon(
                                              CupertinoIcons.bookmark,
                                              size: 28,
                                            );
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    Share.share(widget.description);
                                  },
                                  child: Container(
                                    color: Colors.transparent,
                                    child: const Icon(
                                      Icons.share,
                                      size: 28,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                              ],
                            )
                          : Container();
                    })
              ],
              flexibleSpace: FlexibleSpaceBar(
                title: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 25),
                    child: ValueListenableBuilder(
                      valueListenable: isExpanded,
                      builder: (context, c, v) {
                        return isExpanded.value
                            ? SizedBox(
                                width: w * 0.9,
                                child: RichText(
                                  overflow: TextOverflow.ellipsis,
                                  text: TextSpan(
                                    style: const TextStyle(fontSize: 18),
                                    text: widget.title,
                                  ),
                                  textScaleFactor: 0.85,
                                ),
                              )
                            : SizedBox(
                                width: w * 0.9,
                                child: RichText(
                                  overflow: TextOverflow.ellipsis,
                                  text: TextSpan(
                                    style: const TextStyle(fontSize: 18),
                                    text: widget.title,
                                  ),
                                ),
                              );
                      },
                    )),
                background: Stack(
                  children: [
                    SizedBox(
                        width: w,
                        child: Image.asset(
                          "assets/images/app_banner.jpg",
                          fit: BoxFit.fill,
                        )),
                    Container(
                      color: Colors.black.withOpacity(0.7),
                    ),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Theme.of(context).canvasColor,
                          ),
                          width: w * 0.97,
                          child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 10),
                              child: Text(
                                widget.description,
                                style: Theme.of(context).textTheme.subtitle1,
                                textAlign: TextAlign.justify,
                              )),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  );
                },
                childCount: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
