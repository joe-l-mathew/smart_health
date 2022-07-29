import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:smart_health_project/constants.dart';
import 'package:smart_health_project/models/user_model.dart';
import 'package:smart_health_project/provider/user_provider.dart';

class FirestoreMethods {
  final _firestore = FirebaseFirestore.instance;
  // add user
  Future<void> addUserModel(UserModel userModel) async {
    await _firestore
        .collection(collectionUser)
        .doc(userModel.uid)
        .set(userModel.toMap());
  }

  //get user details

  Future<void> getUserDetails(BuildContext context) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot = await _firestore
        .collection(collectionUser)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    Provider.of<UserProvider>(context, listen: false)
        .setUserModel(UserModel.fromMap(snapshot.data()!));
  }

  Future<void> addPulseDocs(
      {required BuildContext context, required String pulse}) async {
    await _firestore
        .collection(collectionUser)
        .doc(Provider.of<UserProvider>(context, listen: false).userModel!.uid)
        .collection("Pulse")
        .add({'time': DateTime.now(), 'pulse': pulse});
  }
}
