import 'package:englishstories/db/english_stories_database.dart';
import 'package:flutter/cupertino.dart';

DBHelper dbHelper = DBHelper();

ValueNotifier<bool> isBookmarked = ValueNotifier(false);

ValueNotifier<bool> isDarkMode = ValueNotifier(false);
ValueNotifier<bool> isDailyNotification = ValueNotifier(true);
