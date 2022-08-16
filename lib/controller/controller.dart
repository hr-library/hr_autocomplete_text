part of '../hr_autocomplete_text.dart';

class HrAutocompleteTextController {
  final FirestoreUtils _firestoreUtils = FirestoreUtils();
  final GetDialog _getDialog = GetDialog();
  final dataController = TextEditingController();

  void updateScreen() {
    Get.forceAppUpdate();
  }

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

  Future<void> editDefaultData({
    required String oldValue,
    required String newValue,
    required List<String> listDefaultData,
    required String key,
  }) async {
    listDefaultData.add(newValue);
    listDefaultData.remove(oldValue);
    Map<String, dynamic> newList = {
      'key': key,
      'list': listDefaultData,
    };
    await _firestoreUtils.editDefaultDataItem(newList);
  }

  Future<void> removeDefaultData({
    required String value,
    required List<String> listDefaultData,
    required String key,
  }) async {
    listDefaultData.remove(value);
    Map<String, dynamic> newList = {
      'key': key,
      'list': listDefaultData,
    };
    await _firestoreUtils.editDefaultDataItem(newList);
  }

  void showDialogEdit({
    required String key,
    required String value,
    required List<String> listDefaultData,
  }) {
    dataController.text = value;
    _getDialog.showEdit(
      title: key,
      controller: dataController,
      onConfirm: () async {
        Get.back();
        await editDefaultData(
          oldValue: value,
          newValue: dataController.text,
          listDefaultData: listDefaultData,
          key: key,
        );
        Get.forceAppUpdate();
      },
    );
  }

  void showDialogDelete({
    required String value,
    required List<String> listDefaultData,
    required String key,
  }) {
    _getDialog.showDelete(
        value: value,
        onConfirm: () async {
          Get.back();
          await removeDefaultData(
            value: value,
            listDefaultData: listDefaultData,
            key: key,
          );
          Get.forceAppUpdate();
        });
  }
}
