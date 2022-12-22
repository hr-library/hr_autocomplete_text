part of '../hr_autocomplete_text.dart';

/*class DefaultData {
  String? value;

  DefaultData({
    required this.value,
  });

  DefaultData.fromJson(Map<String, dynamic> json) {
    value = json['value'];
  }

  copyWith({
    String? value,
    bool? list,
  }) =>
      DefaultData(
        value: value ?? this.value,
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = value;
    return data;
  }
}*/

class ListDefaultData {
  final String key;
  final String userUid;
  final List<String> list;

  ListDefaultData({
    required this.key,
    required this.list,
    required this.userUid,
  });

  //fromJson
  factory ListDefaultData.fromJson(Map<String, dynamic> json) {
    return ListDefaultData(
      key: json['key'],
      list: json['list'].cast<String>(),
      userUid: json['userUid'],
    );
  }

  //copyWith
  copyWith({
    String? key,
    List<String>? list,
    String? userUid,
  }) =>
      ListDefaultData(
        key: key ?? this.key,
        list: list ?? this.list,
        userUid: userUid ?? this.userUid,
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['key'] = key;
    data['list'] = list;
    data['userUid'] = userUid;
    return data;
  }
}
