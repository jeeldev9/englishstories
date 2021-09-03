import 'package:englishstories/constant_veriable.dart';
import 'package:englishstories/screens/bookmark_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ReadStoryScreen extends StatefulWidget {
  List<String> subCategoryNameList;
  List<String> storyDescription;
  String title;
  String description;
  int index;

  ReadStoryScreen(
      {required this.subCategoryNameList,
      required this.storyDescription,
      required this.title,
      required this.description,
      required this.index});

  @override
  _ReadStoryScreenState createState() => _ReadStoryScreenState();
}

class _ReadStoryScreenState extends State<ReadStoryScreen> {
  late int indexOfTitle;
  late ValueNotifier<String> title;
  late ValueNotifier<String> description;
  late ValueNotifier<int> counter;

  late ScrollController controller;
  late ValueNotifier<bool> isExpanded = ValueNotifier(true);

  @override
  void initState() {
    bool isContain = false;

    //Store value in notifier
    title = ValueNotifier(widget.title);
    description = ValueNotifier(widget.description);
    counter = ValueNotifier(widget.index);

    title.notifyListeners();
    description.notifyListeners();

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
    //get if silver bar is expanded or not
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
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.teal,
      body: SafeArea(
        top: false,
        child: CustomScrollView(
          controller: controller,
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              pinned: true,
              snap: false,
              floating: true,
              expandedHeight: 160.0,
              centerTitle:  true,
              actions: [
                //change light to dark theme
                ValueListenableBuilder(
                    valueListenable: isExpanded,
                    builder: (context, c, v) {
                      return isExpanded.value
                          ? Row(
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      // Get.to();

                                      Get.changeTheme(Get.isDarkMode
                                          ? ThemeData.light()
                                          : ThemeData.dark());
                                    },
                                    child: const Icon(
                                      Icons.dark_mode_outlined,
                                      size: 28,
                                    )),
                                const SizedBox(
                                  width: 15,
                                ),

                                //view all bookmark screen redirect Button
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

                                //Bookmark This Story button
                                GestureDetector(
                                  onTap: () async {
                                    bool isContain = false;

                                    for (int i = 0;
                                        i < dbHelper.bookmarkList.value.length;
                                        i++) {
                                      if (title.value ==
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
                                          title.value, description.value);
                                    } else {
                                      //if already added to list then remove
                                      isBookmarked.value = false;

                                      dbHelper.deleteDataIntoDB(dbHelper
                                          .bookmarkList
                                          .value[indexOfTitle]['id']
                                          .toString());
                                    }
                                    dbHelper.bookmarkList.notifyListeners();
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
                              ],
                            )
                          : Container();
                    }),
              ],
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,

                collapseMode: CollapseMode.pin,
                title: Container(
                  margin: EdgeInsets.symmetric(horizontal: 25),
                  child: ValueListenableBuilder(
                    valueListenable: isExpanded,
                    builder: (context, c, v) {
                      return isExpanded.value
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    if (counter.value == 0) {
                                      print("first index");
                                    } else {
                                      counter.value -= 1;
                                      title.value = widget
                                          .subCategoryNameList[counter.value];
                                      description.value = widget
                                          .storyDescription[counter.value];
                                      title.notifyListeners();
                                      description.notifyListeners();
                                    }
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(1),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border:
                                            Border.all(color: Colors.green)),
                                    child: const Icon(
                                      CupertinoIcons.left_chevron,
                                      color: Colors.white,
                                      size: 10,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10,),
                                ValueListenableBuilder(
                                    valueListenable: title,
                                    builder: (context, c, v) {
                                      return Container(
                                        width: 150,
                                        child: RichText(
                                          overflow: TextOverflow.ellipsis,
                                          text: TextSpan(
                                            style: TextStyle(fontSize: 18),
                                            text: "${title.value}",
                                          ),
                                        ),
                                      );
                                    }),
                                
                                GestureDetector(
                                  onTap: () {
                                    if (counter.value ==
                                        widget.subCategoryNameList.length) {
                                      print("last index");
                                    } else {
                                      counter.value += 1;
                                      title.value = widget
                                          .subCategoryNameList[counter.value];
                                      description.value = widget
                                          .storyDescription[counter.value];
                                      title.notifyListeners();
                                      description.notifyListeners();
                                    }
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(1),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border:
                                            Border.all(color: Colors.green)),
                                    child: const Icon(
                                      CupertinoIcons.right_chevron,
                                      color: Colors.white,
                                      size: 10,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : ValueListenableBuilder(
                              valueListenable: title,
                              builder: (context, c, v) {
                                return Container(
                                  width: 250,
                                  child: RichText(
                                    overflow: TextOverflow.ellipsis,
                                    text: TextSpan(
                                      style: TextStyle(fontSize: 18),
                                      text: "${title.value}",
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                );
                              });
                    },
                  ),
                ),
                background: Stack(
                  children: [
                    Container(
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
                          child: ValueListenableBuilder(
                            valueListenable: description,
                            builder: (context, c, v) {
                              return Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 10),
                                  child: Text(
                                    "${description.value}",
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                    textAlign: TextAlign.justify,
                                  ));
                            },
                          ),
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
