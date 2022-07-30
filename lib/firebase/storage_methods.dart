import 'dart:io';
import 'package:smart_health_project/functions/show_snackbar.dart';
import 'package:ulid/ulid.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:smart_health_project/provider/upload_image_provider.dart';

class StorageMethods {
  final _storage = FirebaseStorage.instance;
  Future<void> addImage(BuildContext context) async {
    // print(Provider.of<UploadImageProvider>(context, listen: false).image!.path);
    try {
      await _storage.ref(Ulid().toUuid()).child("").putFile(File(
          Provider.of<UploadImageProvider>(context, listen: false)
              .image!
              .path));
      // print("completed");
    } catch (e) {
      // print(e);
      showSnackbar(context, e.toString());
    }
  }
}
