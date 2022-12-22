part of '../hr_autocomplete_text.dart';

class HrAutocompleteTextController {
  final FirestoreUtils _firestoreUtils = FirestoreUtils();
  final GetDialog _getDialog = GetDialog();
  final dataController = TextEditingController();

  void updateScreen() {
    Get.forceAppUpdate();
  }

  Future<ListDefaultData> fetchDefaultData({
    required String key,
    required String userUid,
  }) async {
    return await _firestoreUtils.fetchDefaultData(key, userUid);
  }

  Future<ListDefaultData> verifyDefaultData({
    required String value,
    required ListDefaultData listDefaultData,
    required String key,
    required String userUid,
  }) async {
    if (!listDefaultData.list.contains(value)) {
      print("$logTrace Saving....");
      return await addDefaultDataToFirebase(
        data: value,
        listDefaultData: listDefaultData,
        key: key,
        userUid: userUid,
      );
    } else {
      print("$logTrace Already Saved");
      return listDefaultData;
    }
  }

  Future<ListDefaultData> addDefaultDataToFirebase({
    required String data,
    required ListDefaultData listDefaultData,
    required String key,
    required userUid,
  }) async {
    List<String> list = [];
    list.add(data);
    for (String dataPatternInput in listDefaultData.list) {
      list.add(dataPatternInput);
    }
    ListDefaultData listDefaultDataModel = ListDefaultData(
      key: key,
      list: list,
      userUid: userUid,
    );
    await _firestoreUtils.insertDefaultDataItem(listDefaultDataModel);
    return listDefaultDataModel;
  }

  Future<void> editDefaultData({
    required String oldValue,
    required String newValue,
    required ListDefaultData listDefaultData,
  }) async {
    List<String> list = [];
    list.addAll(listDefaultData.list);
    list.add(newValue);
    list.remove(oldValue);
    ListDefaultData listDefaultDataModel = listDefaultData.copyWith(
      list: list,
    );
    await _firestoreUtils.editDefaultDataItem(listDefaultDataModel);
  }

  Future<void> removeDefaultData({
    required String value,
    required ListDefaultData listDefaultData,
  }) async {
    List<String> list = [];
    list.addAll(listDefaultData.list);
    list.remove(value);
    ListDefaultData listDefaultDataModel = listDefaultData.copyWith(
      list: list,
    );
    await _firestoreUtils.editDefaultDataItem(listDefaultDataModel);
  }

  void showDialogEdit({
    required String key,
    required String value,
    required ListDefaultData listDefaultData,
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
        );
        Get.forceAppUpdate();
      },
    );
  }

  void showDialogDelete({
    required String value,
    required ListDefaultData listDefaultData,
    required String key,
  }) {
    _getDialog.showDelete(
        value: value,
        onConfirm: () async {
          Get.back();
          await removeDefaultData(
            value: value,
            listDefaultData: listDefaultData,
          );
          Get.forceAppUpdate();
        });
  }
}
