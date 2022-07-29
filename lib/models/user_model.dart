import 'dart:convert';

class UserModel {
  final String name;
  final String email;
  final String? heartRate;
  final String? uid;
  UserModel({
    required this.name,
    required this.email,
    this.heartRate,
    this.uid,
  });

  UserModel copyWith({
    String? name,
    String? email,
    String? heartRate,
    String? uid,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      heartRate: heartRate ?? this.heartRate,
      uid: uid ?? this.uid,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'name': name});
    result.addAll({'email': email});
    if(heartRate != null){
      result.addAll({'heartRate': heartRate});
    }
    if(uid != null){
      result.addAll({'uid': uid});
    }
  
    return result;
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      heartRate: map['heartRate'],
      uid: map['uid'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));
}
