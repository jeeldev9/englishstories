import 'package:englishstories/screens/sub_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class ShowCategoryContainerWidget extends StatelessWidget {
  late String imageName;
  late String categoryName;
  late String subCategoryID;

  ShowCategoryContainerWidget({required this.imageName,required this.categoryName,required this.subCategoryID,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Get.to(()=>SubCategoryScreen(subID:subCategoryID , title: categoryName));
      },
      child: Card(
        shadowColor: Colors.deepPurple,
        elevation: 4.0,
        margin: const EdgeInsets.symmetric(vertical: 6),
        child: Container(

          padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Theme.of(context).cardColor,
          ),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Card(child: Image.asset(imageName,height: 60,width: 60,)),
                  const SizedBox(width: 10,),
                   Text(categoryName,style:Theme.of(context).textTheme.headline6),
                ],
              ),
              Image.asset("assets/images/arrow_blue.png",height: 40,width: 35,),

            ],
          ),
        ),
      ),
    );
  }
}
