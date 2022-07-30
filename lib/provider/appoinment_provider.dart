import 'package:flutter/cupertino.dart';

class AppoinmenetProvider with ChangeNotifier {
  String? patientName;
  DateTime? requiredDate;
  bool? isAproved;

  setName({required name}) {
    patientName = name;
    notifyListeners();
  }

  setDate(DateTime date) {
    requiredDate = date;
    notifyListeners();
  }

  setIsAproved(bool? aproved) {
    isAproved = aproved;
    notifyListeners();
  }
}
