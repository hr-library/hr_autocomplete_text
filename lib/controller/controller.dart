part of '../hr_autocomplete_text.dart';

class HrAutocompleteTextController {
  final FirestoreUtils _firestoreUtils = FirestoreUtils();

  Future<List<String>> fetchDefaultData({required String key}) async {
    return await _firestoreUtils.fetchDefaultData(key);
  }

  Future<List<String>> verifyInDefaultData({
    required String value,
    required List<String> listDefaultData,
    required String key,
  }) async {
    if (!listDefaultData.contains(value)) {
      print("$logTrace Saving....");
      return await addDefaultDataToFirebase(value, listDefaultData, key);
    } else {
      print("$logTrace Already Saved");
      return listDefaultData;
    }
  }

  Future<List<String>> addDefaultDataToFirebase(
      String data, List<String> listDefaultData, String key) async {
    List<String> list = [];
    list.add(data);
    for (String dataPatternInput in listDefaultData) {
      list.add(dataPatternInput);
    }
    Map<String, dynamic> newList = {
      'key': key,
      'list': list,
    };
    await _firestoreUtils.insertDefaultDataItem(newList);
    return list;
  }
}
