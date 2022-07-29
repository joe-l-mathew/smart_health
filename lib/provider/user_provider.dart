import 'package:flutter/cupertino.dart';
import 'package:smart_health_project/models/user_model.dart';

class UserProvider with ChangeNotifier {
  UserModel? userModel;
  setUserModel(UserModel model) {
    userModel = model;
    notifyListeners();
  }
}
