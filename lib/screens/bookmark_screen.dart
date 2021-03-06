import 'package:englishstories/screens/read_bookmark_story.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constant_veriable.dart';


class BookMarkScreen extends StatelessWidget {
  const BookMarkScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double w=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: const Text("Bookmarks"),
      ),
      body:SingleChildScrollView(
        child: ValueListenableBuilder(
          valueListenable: dbHelper.bookmarkList,
          builder: (context,c,v){
            return Column(
              children: List.generate(dbHelper.bookmarkList.value.length, (index) =>  GestureDetector(
                onTap: (){
                  Get.to(()=>ReadBookmarkStory(title: dbHelper.bookmarkList.value[index]['title'], description:dbHelper. bookmarkList.value[index]['description']));
                },
                child: Card(
                  shadowColor: Colors.deepPurple,
                  elevation: 4.0,
                  margin: const EdgeInsets.symmetric(vertical: 8,horizontal: 10),
                  child: Container(

                    padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Theme.of(context).cardColor,
                    ),

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [

                            SizedBox(
                                width:w*0.7,child: Text(dbHelper.bookmarkList.value[index]['title'],style: Theme.of(context).textTheme.subtitle1)),
                          ],
                        ),
                        Image.asset("assets/images/arrow_blue.png",height: 40,width: 35,),

                      ],
                    ),
                  ),
                ),
              )),
            );
          },
        ),
      ),
    );
  }
}

