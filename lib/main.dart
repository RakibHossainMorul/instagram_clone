import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/responsive/mobile_screen_layout.dart';
import 'package:instagram_clone/screens/login_screen.dart';
import 'package:instagram_clone/screens/sign_up_screen.dart';
import 'package:instagram_clone/utils/colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
      apiKey: "AIzaSyDByL6lQdcPACCV3Qy7JDBQvI7vc3VdDqM",
      authDomain: "instagram-clone-833ea.firebaseapp.com",
      projectId: "instagram-clone-833ea",
      storageBucket: "instagram-clone-833ea.appspot.com",
      messagingSenderId: "921470629228",
      appId: "1:921470629228:web:f08bb312d4033adf25af49",
    ));
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Instagram Clone',
      //set the background color of screen for this application.
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: mobileBackgroundColor,
      ),
      home: const SignUpScreen(),
      //const ResponsiveLayout( webLayout: WebLayout(), mobileLayout: MobileLayout()),
    );
  }
}
