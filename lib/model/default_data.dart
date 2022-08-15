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
  String? key;
  List<String>? list;

  ListDefaultData({
    required this.key,
    required this.list,
  });

  ListDefaultData.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    list = json['list'];
  }

  copyWith({
    String? key,
    List<String>? list,
  }) =>
      ListDefaultData(
        key: key ?? this.key,
        list: list ?? this.list,
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['key'] = key;
    data['list'] = list;
    return data;
  }
}
