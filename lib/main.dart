import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_health_project/provider/appoinment_provider.dart';
import 'package:smart_health_project/provider/bottom_navigation_provider.dart';
import 'package:smart_health_project/provider/upload_image_provider.dart';
import 'package:smart_health_project/provider/user_provider.dart';

import 'package:smart_health_project/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      // options: DefaultFirebaseOptions.currentPlatform,
      );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => BottomNavigationBarProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => AppoinmenetProvider()),
        ChangeNotifierProvider(create: (context) => UploadImageProvider())
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          darkTheme: ThemeData.dark(),
          themeMode: ThemeMode.dark,
          title: 'Flutter Demo',
          theme: ThemeData(
              primarySwatch: Colors.amber,
              primaryColor: Colors.amber,
              primaryColorDark: Colors.amber),
          home: const SplashScreen()),
    );
  }
}
