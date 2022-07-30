import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class UploadImageProvider with ChangeNotifier {
  XFile? image;
  setImage(newImg) {
    image = newImg;
    notifyListeners();
  }
}
