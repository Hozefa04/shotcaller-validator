import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shotcaller_validator/screens/home_page.dart';
import 'package:shotcaller_validator/utils/app_strings.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ShotCallerValidator());
}

class ShotCallerValidator extends StatelessWidget {
  const ShotCallerValidator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppStrings.appName,
      home: const HomePage(),
    );
  }
}