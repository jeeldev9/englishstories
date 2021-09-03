import 'package:englishstories/constant_veriable.dart';
import 'package:englishstories/screens/bookmark_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReadBookmarkStory extends StatefulWidget {

  String title;
  String description;

  ReadBookmarkStory({required this.title,required this.description});

  @override
  _ReadBookmarkStoryState createState() => _ReadBookmarkStoryState();
}

class _ReadBookmarkStoryState extends State<ReadBookmarkStory> {

  late int indexOfTitle;

  @override
  void initState() {
    bool isContain=false;
    for(int i=0;i<dbHelper.bookmarkList.value.length;i++){
      if(widget.title==dbHelper.bookmarkList.value[i]['title']){
        isContain=true;
      }
    }
    //If not contain in list them add
    if(isContain==true){
      isBookmarked.value=true;
    }
    else{
      isBookmarked.value=false;
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double h=MediaQuery.of(context).size.height;
    double w=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.teal,
      body: SafeArea(
        top: false,
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              pinned:true,
              snap: true,
              floating: true,
              expandedHeight: 160.0,
              actions:  [

                GestureDetector(
                    onTap:(){
                      // Get.to();

                      Get.changeTheme(Get.isDarkMode?ThemeData.light():ThemeData.dark());

                    },child: const Icon(Icons.dark_mode_outlined,size: 28,)),
                const SizedBox(width: 15,),
                GestureDetector(
                  onTap: (){

                    Get.to(()=>const BookMarkScreen());
                  },
                  child:const Icon(
                    Icons.book_outlined,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 15,),
                GestureDetector(
                  onTap: ()async{
                    bool isContain=false;

                    for(int i=0;i<dbHelper.bookmarkList.value.length;i++){
                      if(widget.title==dbHelper.bookmarkList.value[i]['title']){
                        isContain=true;
                        indexOfTitle=i;
                      }
                    }
                    //If not contain in list them add
                    if(isContain==false){

                      isBookmarked.value=true;
                      //Add title and description in List
                      // dbHelper.bookmarkList.value.add({
                      //   "title":widget.title,
                      //   "description":widget.description,
                      // });
                      //store Bookmark in database

                      dbHelper.insertDataIntoDB(widget.title, widget.description);

                    }else{
                      //if already added to list then remove
                      isBookmarked.value=false;

                      dbHelper.deleteDataIntoDB(dbHelper.bookmarkList.value[indexOfTitle]['id'].toString());
                    }
                    dbHelper.bookmarkList.notifyListeners();
                  },
                  child: ValueListenableBuilder(
                    valueListenable: isBookmarked,
                    builder: (context,v,c){
                      return isBookmarked.value?const Icon(
                        CupertinoIcons.bookmark_solid,
                        size: 28,
                        color: Colors.red,
                      ):const Icon(
                        CupertinoIcons.bookmark,
                        size: 28,

                      );
                    },
                  ),
                ),
                const SizedBox(width: 15,),

              ],
              flexibleSpace: FlexibleSpaceBar(
                title: Container(
                  margin: EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    width: 150,
                    child: RichText(
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        style: TextStyle(fontSize: 18),
                        text: "${widget.title}",
                      ),
                    ),
                  ),
                ),
                background:Stack(
                  children: [
                    Container(
                        width:w,child: Image.asset("assets/images/app_banner.jpg",fit: BoxFit.fill,)),
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
                      const SizedBox(height: 20,),
                      Center(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Theme.of(context).canvasColor,
                          ),
                          width: w*0.97,
                          child: Container(
                              padding:EdgeInsets.symmetric(horizontal: 12,vertical: 10),child: Text("${widget.description}",style:Theme.of(context).textTheme.subtitle1,textAlign: TextAlign.justify,)),
                        ),
                      ),const SizedBox(height: 20,),

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
