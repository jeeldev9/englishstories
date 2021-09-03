import 'package:englishstories/constant_veriable.dart';
import 'package:englishstories/widgets/catagory_home_show_category_container_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'bookmark_screen.dart';

class CategoryHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // print("${dbHelper.remedieTypeDataList}");
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: const Text("English Stories"),
      ),
      drawer: Drawer(
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            Image.asset("assets/images/bg_intro.jpg",fit: BoxFit.fill,height: MediaQuery.of(context).size.height*0.23,),
            const SizedBox(height: 10,),
            ListTile(
              tileColor: context.theme.highlightColor,
              title: Row(
                children:  [
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
                children:  [
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
                  "More",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                )),
            ListTile(
              title:Row(
                children:  [
                  Icon(CupertinoIcons.share,color:context.theme.iconTheme.color,),
                  const SizedBox(width: 30,),
                  const Text('Share App'),
                ],
              ),
              onTap: () {
                Get.back();
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: List.generate(
                dbHelper.remedieTypeDataList.length,
                (index) => ShowCategoryContainerWidget(
                      subCategoryID: (index + 1).toString(),
                      categoryName:
                          "${dbHelper.remedieTypeDataList[index]['REMEDIE_NAME']}",
                      imageName:
                          "assets/images/${dbHelper.remedieTypeDataList[index]['IMAGE_NAME']}.png",
                    )),
          ),
        ),
      ),
    );
  }
}
