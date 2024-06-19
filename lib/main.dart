import 'package:flutter/material.dart';
import 'splash_screen.dart';
import 'package:get/get.dart';
// import 'package:hive/hive.dart';
// import 'package:path_provider/path_provider.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // final documentsDir = await getApplicationDocumentsDirectory();
  // Hive.init(documentsDir.path);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
