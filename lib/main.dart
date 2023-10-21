import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:virtual_shield/core/local_storage/app_preferences.dart';

import 'presentation/screens/home_screen.dart';

late Size sizeScreen;

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await AppPreferences.initHive();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Virtual Shield',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          centerTitle: true,elevation: 0
        ),
        iconTheme:const IconThemeData(
          color: Colors.black
        ),
        textTheme: const TextTheme(
            titleLarge: TextStyle(
                fontSize: 18,fontWeight: FontWeight.w400,
                color: Colors.black
            ),
          labelMedium: TextStyle(
              fontSize: 16,fontWeight: FontWeight.w600,
              color: Colors.black
          ),
          labelSmall: TextStyle(
              fontSize: 12,fontWeight: FontWeight.w600,
              color: Colors.black
          ),
        ),
      ),
      themeMode: AppPreferences.isModeDark ? ThemeMode.dark : ThemeMode.light,
      darkTheme: ThemeData(
        scaffoldBackgroundColor: Colors.grey[900],
        iconTheme:const IconThemeData(
            color: Colors.white
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 18,fontWeight: FontWeight.w400,
            color: Colors.white
          ),
          labelMedium: TextStyle(
              fontSize: 16,fontWeight: FontWeight.w600,
              color: Colors.white
          ),
          labelSmall: TextStyle(
              fontSize: 12,fontWeight: FontWeight.w600,
              color: Colors.white
          ),
        ),
        brightness: Brightness.dark,
        appBarTheme: AppBarTheme(
             backgroundColor: Colors.grey[900],
            centerTitle: true,elevation: 0
        ),
      ),
      home: HomeScreen(),
    );
  }
}
extension AppTheme on ThemeData{
   Color get lightTextColor => AppPreferences.isModeDark ? Colors.white70 : Colors.black54;
   Color get bottomNavigationColor => AppPreferences.isModeDark ? Colors.white12 : Colors.redAccent;
}
