import 'dart:convert';

class AppoinmentModel {
  String userName;
  String doctorName;
  DateTime requiredDate;
  String uid;
  String isAproved;
  AppoinmentModel({
    required this.userName,
    required this.doctorName,
    required this.requiredDate,
    required this.uid,
    required this.isAproved,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'userName': userName});
    result.addAll({'doctorName': doctorName});
    result.addAll({'requiredDate': requiredDate.millisecondsSinceEpoch});
    result.addAll({'uid': uid});
    result.addAll({'isAproved': isAproved});

    return result;
  }

  factory AppoinmentModel.fromMap(Map<String, dynamic> map) {
    return AppoinmentModel(
      userName: map['userName'] ?? '',
      doctorName: map['doctorName'] ?? '',
      requiredDate: DateTime.fromMillisecondsSinceEpoch(map['requiredDate']),
      uid: map['uid'] ?? '',
      isAproved: map['isAproved'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AppoinmentModel.fromJson(String source) =>
      AppoinmentModel.fromMap(json.decode(source));
}
