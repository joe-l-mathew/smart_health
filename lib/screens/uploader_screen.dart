// ignore_for_file: avoid_renaming_method_parameters, use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:smart_health_project/firebase/firebase_auth.dart';
import 'package:smart_health_project/firebase/storage_methods.dart';
import 'package:smart_health_project/functions/show_snackbar.dart';
import 'package:smart_health_project/provider/bottom_navigation_provider.dart';
import 'package:smart_health_project/provider/upload_image_provider.dart';

class UploaderScreen extends StatelessWidget {
  const UploaderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context1) {
    final ImagePicker picker = ImagePicker();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upload recipts"),
        actions: [
          IconButton(
              onPressed: () {
                AuthMethods().logoutUser(context1);
              },
              icon: (const Icon(Icons.logout)))
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Provider.of<UploadImageProvider>(context1).image?.path == null
                ? const SizedBox(
                    height: 300,
                  )
                : SizedBox(
                    height: 300,
                    child: Image.file(File(
                        Provider.of<UploadImageProvider>(context1)
                            .image!
                            .path)),
                  ),
            Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () async {
                      final XFile? photo =
                          await picker.pickImage(source: ImageSource.camera);
                      Provider.of<UploadImageProvider>(context1, listen: false)
                          .setImage(photo);
                    },
                    child: const Text("Camera")),
                ElevatedButton(
                    onPressed: () async {
                      final ImagePicker picker = ImagePicker();
                      final XFile? photo =
                          await picker.pickImage(source: ImageSource.gallery);
                      Provider.of<UploadImageProvider>(context1, listen: false)
                          .setImage(photo);
                    },
                    child: const Text("Gallery")),
              ],
            )),
            const SizedBox(
              height: 30,
            ),
            Provider.of<UploadImageProvider>(context1).image == null
                ? const SizedBox()
                : ElevatedButton(
                    onPressed: () async {
                      await StorageMethods().addImage(context1);
                      Provider.of<UploadImageProvider>(context1, listen: false)
                          .setImage(null);
                      // Navigator.pop(context1);

                      showSnackbar(context1, "Uploaded");
                      Provider.of<BottomNavigationBarProvider>(context1,
                              listen: false)
                          .currentIndex = 0;
                    },
                    child: const Text("Upload"))
          ],
        ),
      ),
    );
  }
}
