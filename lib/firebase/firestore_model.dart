import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:smart_health_project/constants.dart';
import 'package:smart_health_project/functions/show_snackbar.dart';
import 'package:smart_health_project/models/appinment_model.dart';
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
    // ignore: use_build_context_synchronously
    Provider.of<UserProvider>(context, listen: false)
        .setUserModel(UserModel.fromMap(snapshot.data()!));
  }

  Future<void> addPulseDocs(
      {required BuildContext context, required String pulse}) async {
    await _firestore
        .collection(collectionUser)
        .doc(Provider.of<UserProvider>(context, listen: false).userModel!.uid)
        .collection(collectionPulse)
        .add({'time': DateTime.now(), 'pulse': pulse});
  }

  //add booked appoinments

  Future<void> addAppinmet(AppoinmentModel model, BuildContext context) async {
    DocumentReference<Map<String, dynamic>> ref = await _firestore
        .collection(collectionUser)
        .doc(Provider.of<UserProvider>(context, listen: false).userModel!.uid)
        .collection(collectionAppoinment)
        .add(model.toMap());

    await _firestore.collection("aproval").add({
      "path": ref.path,
      "Date": model.requiredDate,
      "Doctor": model.doctorName
    });
    // ignore: use_build_context_synchronously
    showSnackbar(context, "Booking done, conformation pending");
  }

  Future<void> onAproval(String path, String path2) async {
    await _firestore.doc(path).update({'isAproved': "Aproved"});
    await _firestore.doc(path2).delete();
  }

  
  Future<void> onRejection(String path, String path2) async {
    await _firestore.doc(path).update({'isAproved': "Rejected"});
    await _firestore.doc(path2).delete();
  }
}
