import 'package:flutter/material.dart';
import 'package:student_with_getx/model/getx_class.dart';
import 'package:student_with_getx/model/student_model.dart';
import 'package:student_with_getx/splash.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main()async{
  await Hive.initFlutter();
  Hive.registerAdapter(DetailsAdapter());
  Get.put(StudentController());
  Get.put(ImageController());
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Splash(),
    );
  }
}