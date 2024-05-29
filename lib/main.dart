import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_hunt/utlis/utils.dart';

import 'onbording_screen/onboarding_screen.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> initialization = Firebase.initializeApp();
   MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.scaffloadcolor,
        useMaterial3: true,
      ),
      home:const OnBoarding_Screen(),
    );
  }
}

