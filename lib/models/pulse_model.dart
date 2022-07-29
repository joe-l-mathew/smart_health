import 'dart:convert';

class PulseModel {
  DateTime time;
  String pulse;
  PulseModel({
    required this.time,
    required this.pulse,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'time': time.millisecondsSinceEpoch});
    result.addAll({'pulse': pulse});

    return result;
  }

  factory PulseModel.fromMap(Map<String, dynamic> map) {
    return PulseModel(
      time: DateTime.fromMillisecondsSinceEpoch(map['time']),
      pulse: map['pulse'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PulseModel.fromJson(String source) =>
      PulseModel.fromMap(json.decode(source));

  PulseModel copyWith({
    DateTime? time,
    String? pulse,
  }) {
    return PulseModel(
      time: time ?? this.time,
      pulse: pulse ?? this.pulse,
    );
  }
}
