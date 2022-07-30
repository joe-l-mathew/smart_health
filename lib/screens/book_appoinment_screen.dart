import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smart_health_project/constants.dart';
import 'package:smart_health_project/provider/user_provider.dart';
import 'package:smart_health_project/screens/admin_screen.dart';

class BookAppoinmentScreen extends StatelessWidget {
  const BookAppoinmentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (builder) => const AdminPanelScreen()));
              },
              icon: const Icon(Icons.admin_panel_settings))
        ],
        title: const Text("My Bookings"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(collectionUser)
            .doc(Provider.of<UserProvider>(context).userModel!.uid!)
            .collection(collectionAppoinment)
            .snapshots(),
        // initialData: initialData,
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LinearProgressIndicator();
          } else {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  DateTime date = DateTime.fromMillisecondsSinceEpoch(
                      snapshot.data!.docs[index]['requiredDate']);
                  // snapshot.data!.docs.fr
                  return Card(
                    child: ListTile(
                        title: Text(
                            "Doctor name: ${snapshot.data!.docs[index]['doctorName']}"),
                        subtitle: Text(
                          DateFormat(
                            'dd-MM-yyyy',
                          ).format(date),
                        ),
                        trailing: Text(
                          snapshot.data!.docs[index]['isAproved'],
                        )),
                  );
                });
          }
        },
      ),
    );
  }
}
