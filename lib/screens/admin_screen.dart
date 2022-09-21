import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_health_project/firebase/firestore_model.dart';

class AdminPanelScreen extends StatelessWidget {
  const AdminPanelScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Appoinments"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('aproval').snapshots(),
        builder: ((BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LinearProgressIndicator();
          } else {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  DateTime newDate = DateTime.parse(
                      snapshot.data!.docs[index]['Date'].toDate().toString());
                  //  DateTime.fromMillisecondsSinceEpoch(
                  //     snapshot.data!.docs[index]['Date']);
                  return Card(
                      child: ListTile(
                          onLongPress: () {
                            FirestoreMethods().onRejection(
                                snapshot.data!.docs[index]['path'],
                                snapshot.data!.docs[index].reference.path);
                          },
                          title: Text(snapshot.data!.docs[index]['Doctor']),
                          subtitle: Text(
                            DateFormat(
                              'dd-MM-yyyy',
                            ).format(newDate),
                            style: const TextStyle(fontSize: 30),
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              FirestoreMethods().onAproval(
                                  snapshot.data!.docs[index]['path'],
                                  snapshot.data!.docs[index].reference.path);
                            },
                            icon: const Icon(Icons.check),
                          )));
                });
          }
        }),
      ),
    );
  }
}
