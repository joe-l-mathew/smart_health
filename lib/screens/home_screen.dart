// ignore_for_file: implementation_imports, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_health_project/constants.dart';
import 'package:smart_health_project/firebase/firestore_model.dart';
import 'package:smart_health_project/models/user_model.dart';
import 'package:smart_health_project/provider/bottom_navigation_provider.dart';
import 'package:smart_health_project/provider/user_provider.dart';
import 'package:smart_health_project/screens/add_appoinment_screen.dart';
import 'package:smart_health_project/screens/pulse_analyser_screen.dart';
import 'package:smart_health_project/screens/uploader_screen.dart';

import 'book_appoinment_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    FirestoreMethods().getUserDetails(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          if (Provider.of<BottomNavigationBarProvider>(context, listen: false)
                  .currentIndex ==
              0) {
            UserModel newModel =
                Provider.of<UserProvider>(context, listen: false)
                    .userModel!
                    .copyWith(heartRate: null);
            FirebaseFirestore.instance
                .collection(collectionUser)
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .update({'heartRate': null});
            FirestoreMethods().getUserDetails(context);
            // Provider.of<UserProvider>(context, listen: false)
            //     .setUserModel(newModel);
          } else if (Provider.of<BottomNavigationBarProvider>(context,
                      listen: false)
                  .currentIndex ==
              1) {
            Navigator.push(context,
                MaterialPageRoute(builder: (builder) => AddAppoinmentScreen()));
          }
        },
      ),
      body:
          pages[Provider.of<BottomNavigationBarProvider>(context).currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex:
            Provider.of<BottomNavigationBarProvider>(context).currentIndex,
        items: bottomnavItem,
        onTap: (e) {
          Provider.of<BottomNavigationBarProvider>(context, listen: false)
              .currentIndex = e;
        },
      ),
    );
  }
}

final pages = [
  const PulseAnalyser(),
  const BookAppoinmentScreen(),
  const UploaderScreen()
];
final bottomnavItem = [
  const BottomNavigationBarItem(
      icon: Icon(Icons.favorite), label: "Pulse Analyser"),
  const BottomNavigationBarItem(
      icon: Icon(Icons.book_online), label: "Book Appoinment"),
  const BottomNavigationBarItem(icon: Icon(Icons.upload), label: "Uploader")
];
