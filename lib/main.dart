import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:valetclub_valet/common/theme.dart';
import 'package:valetclub_valet/firebase_options.dart';
import 'package:valetclub_valet/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Valet Club",
        theme: ThemeData(scaffoldBackgroundColor: MainTheme.mainColor),
        home: const SplashScreen());
  }
}
