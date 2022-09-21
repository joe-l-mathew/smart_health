// ignore_for_file: unnecessary_import, prefer_const_constructors, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_health_project/constants.dart';
import 'package:smart_health_project/firebase/firestore_model.dart';
import 'package:smart_health_project/provider/user_provider.dart';

class PulseAnalyser extends StatelessWidget {
  const PulseAnalyser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pulseController = TextEditingController();
    return Provider.of<UserProvider>(context).userModel == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Column(
            children: [
              Container(
                height: 200,
                color: (Colors.amber),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 30, 10, 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Name : ${Provider.of<UserProvider>(context).userModel!.name}",
                            style: TextStyle(color: Colors.black),
                          ),
                          Provider.of<UserProvider>(context)
                                      .userModel!
                                      .heartRate ==
                                  null
                              ? SizedBox()
                              : CircleAvatar(
                                  child: Text(Provider.of<UserProvider>(context)
                                      .userModel!
                                      .heartRate!),
                                ),
                        ],
                      ),
                      Provider.of<UserProvider>(context).userModel!.heartRate ==
                              null
                          ? Row(
                              children: [
                                Expanded(
                                    child: TextFormField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                  controller: pulseController,
                                )),
                                ElevatedButton(
                                    onPressed: () async {
                                      var newUser = Provider.of<UserProvider>(
                                              context,
                                              listen: false)
                                          .userModel!
                                          .copyWith(
                                              heartRate: pulseController.text);
                                      await FirestoreMethods()
                                          .addUserModel(newUser);
                                      FirestoreMethods()
                                          .getUserDetails(context);
                                      await FirestoreMethods().addPulseDocs(
                                          context: context,
                                          pulse: pulseController.text);
                                    },
                                    child: Text("Add"))
                              ],
                            )
                          : int.parse(Provider.of<UserProvider>(context)
                                      .userModel!
                                      .heartRate!) <
                                  100
                              ? Text(
                                  "Your Heart rate is normal",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20),
                                )
                              : Text(
                                  """-Breathe deeply. It will help you relax until your palpitations pass.
-Splash your face with cold water. It stimulates a nerve that controls your heart rate.
-Don’t panic. Stress and anxiety will make your palpitations worse.""",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 14),
                                )
                    ],
                  ),
                ),
              ),
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection(collectionUser)
                      .doc(Provider.of<UserProvider>(context, listen: false)
                          .userModel!
                          .uid)
                      .collection("Pulse")
                      .snapshots(),
                  builder: (BuildContext contexts,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                          snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return Expanded(
                          child: ListView.builder(
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                                leading: CircleAvatar(
                                    child: Text(
                                        snapshot.data!.docs[index]['pulse'])),
                                trailing: Text(DateTime.parse(snapshot
                                        .data!.docs[index]['time']
                                        .toDate()
                                        .toString())
                                    .toString())),
                          );
                        },
                        itemCount: snapshot.data!.docs.length,
                      ));
                    }
                  })
            ],
          );
  }
}
