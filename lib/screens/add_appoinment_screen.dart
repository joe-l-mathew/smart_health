
// ignore_for_file: use_build_context_synchronously, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smart_health_project/firebase/firestore_model.dart';
import 'package:smart_health_project/functions/show_snackbar.dart';
import 'package:smart_health_project/models/appinment_model.dart';
import 'package:smart_health_project/provider/appoinment_provider.dart';
import 'package:smart_health_project/provider/user_provider.dart';

class AddAppoinmentScreen extends StatelessWidget {
  final nameController = TextEditingController();
  final docController = TextEditingController();
  AddAppoinmentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Get appoinment"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: nameController,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: "Patient name"),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              keyboardType: TextInputType.name,
              controller: docController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: "Doctor name"),
            ),
            const SizedBox(
              height: 20,
            ),
            Provider.of<AppoinmenetProvider>(context).requiredDate == null
                ? ElevatedButton(
                    onPressed: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now().add(const Duration(days: 1)),
                        firstDate: DateTime.now().add(const Duration(days: 1)),
                        lastDate: DateTime.now().add(const Duration(days: 30)),
                      );

                      if (pickedDate != null) {
                        // ignore: use_build_context_synchronously
                        Provider.of<AppoinmenetProvider>(context, listen: false)
                            .setDate(pickedDate);
                      }
                    },
                    child: const Text("Pick a date"))
                : TextButton(
                    child: Text(
                      DateFormat(
                        'dd-MM-yyyy',
                      ).format(Provider.of<AppoinmenetProvider>(context)
                          .requiredDate!),
                      style: const TextStyle(fontSize: 30),
                    ),
                    onPressed: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now().add(const Duration(days: 1)),
                        firstDate: DateTime.now().add(const Duration(days: 1)),
                        lastDate: DateTime.now().add(const Duration(days: 30)),
                      );

                      if (pickedDate != null) {
                        Provider.of<AppoinmenetProvider>(context, listen: false)
                            .setDate(pickedDate);
                      }
                    },
                  )
          ],
        ),
      ),
      floatingActionButton: ElevatedButton(
          onPressed: () async {
            if (nameController.text.isNotEmpty &&
                Provider.of<AppoinmenetProvider>(context, listen: false)
                        .requiredDate !=
                    null &&
                docController.text.isNotEmpty) {
              await FirestoreMethods().addAppinmet(
                  AppoinmentModel(
                      isAproved: "Waiting for aproval",
                      userName: nameController.text,
                      doctorName: docController.text,
                      requiredDate: Provider.of<AppoinmenetProvider>(context,
                              listen: false)
                          .requiredDate!,
                      uid: Provider.of<UserProvider>(context, listen: false)
                          .userModel!
                          .uid!),
                  context);
              Navigator.pop(context);
            } else {
              showSnackbar(context, "Fill all fields");
            }
            //on submit
          },
          child: const Text("Submit")),
    );
  }
}

Future<void> pickDate(BuildContext context) async {
  DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now().add(const Duration(days: 1)),
    firstDate: DateTime.now().add(const Duration(days: 1)),
    lastDate: DateTime.now().add(const Duration(days: 30)),
  );

  if (pickedDate != null) {
    Provider.of<AppoinmenetProvider>(context, listen: false)
        .setDate(pickedDate);
  }
}
