import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_health_project/provider/bottom_navigation_provider.dart';
import 'package:smart_health_project/provider/user_provider.dart';
import 'package:smart_health_project/screens/login_screen.dart';
import 'package:smart_health_project/screens/signup_screen.dart';
import 'package:smart_health_project/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      // options: DefaultFirebaseOptions.currentPlatform,
      );
  runApp(MyApp());
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
      ],
      child: MaterialApp(
          darkTheme: ThemeData.dark(),
          themeMode: ThemeMode.dark,
          title: 'Flutter Demo',
          theme: ThemeData(
              primarySwatch: Colors.amber,
              primaryColor: Colors.amber,
              primaryColorDark: Colors.amber),
          home: SplashScreen()),
    );
  }
}
