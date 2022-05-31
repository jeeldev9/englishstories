import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';



  class DBHelper{
    late Database db;
    List remediesDataList=[];
    List remedieSubTypeDataList=[];
    List remedieTypeDataList=[];
    ValueNotifier<List<Map>> bookmarkList=ValueNotifier([]);


    List<Map<String,String>> shortStories=[];
    Future databaseGet()async{
      var databasesPath = await getDatabasesPath();
      var path = join(databasesPath, "9brainztutorial.db");

// Check if the database exists
      var exists = await databaseExists(path);

      if (!exists) {
        // Should happen only the first time you launch your application

        // Make sure the parent directory exists
        try {
          await Directory(dirname(path)).create(recursive: true);
        } catch (_) {}

        // Copy from asset
        ByteData data = await rootBundle.load(join("assets", "9brainztutorial.db"));
        List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

        // Write and flush the bytes written
        await File(path).writeAsBytes(bytes, flush: true);

      } else {
      }
// open the database
      var db = await openDatabase(path);

      remediesDataList=await db.query('REMEDIES');
      remedieSubTypeDataList=await db.query('REMEDIE_SUB_TYPE');
      remedieTypeDataList=await db.query('REMEDIE_TYPE');
      bookmarkList.value=await db.query("bookmark");

    }
    //Insert into Database
    void  insertDataIntoDB(String title,String description)async{
      var databasesPath = await getDatabasesPath();
      var path = join(databasesPath, "9brainztutorial.db");
      var db = await openDatabase(path);


      Map<String,dynamic> value={
        'title':title,
        'description':description,
      };
      await db.insert("bookmark",value);
      bookmarkList.value=await db.query("bookmark");
    }

    void  deleteDataIntoDB(String id)async{
      var databasesPath = await getDatabasesPath();
      var path = join(databasesPath, "9brainztutorial.db");
      var db = await openDatabase(path);

      await db.delete("bookmark", where: 'id==$id');
      bookmarkList.value=await db.query("bookmark");
    }
  }

























