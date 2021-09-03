import 'package:englishstories/constant_veriable.dart';
import 'package:englishstories/screens/read_stories_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SubCategoryScreen extends StatefulWidget {
  late String subID;
  late String title;
SubCategoryScreen({required this.subID,required this.title});

  @override
  State<SubCategoryScreen> createState() => _SubCategoryScreenState();
}

class _SubCategoryScreenState extends State<SubCategoryScreen> {
List<String> subCategoryNameList=[];
List<String> storyDescription=[];

void getSubcategoryList(){

 for(int i=0;i<dbHelper.remediesDataList.length;i++){

   if(dbHelper.remediesDataList[i]['TYPE_ID']==int.parse(widget.subID)){
     subCategoryNameList.add(dbHelper.remediesDataList[i]['NAME']);
     storyDescription.add(dbHelper.remediesDataList[i]['DESCRIPTION']);
   }
 }
}
@override
  void initState() {
  getSubcategoryList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
  double w=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children:

            List.generate(subCategoryNameList.length, (index) =>  GestureDetector(
              onTap: (){
                Get.to(()=>ReadStoryScreen(subCategoryNameList:subCategoryNameList,storyDescription:storyDescription,index:index,title: subCategoryNameList[index], description: storyDescription[index]));
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
                              width:w*0.7,child: Text(subCategoryNameList[index],style: Theme.of(context).textTheme.subtitle1)),
                        ],
                      ),
                      Image.asset("assets/images/arrow_blue.png",height: 40,width: 35,),

                    ],
                  ),
                ),
              ),
            )),
        ),
      ),
    );
  }
}
