import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hr_autocomplete_text/hr_autocomplete_text.dart';

class HomePageController extends GetxController {
  Rxn<ListDefaultData> listPattern = Rxn<ListDefaultData>();
  Rxn<ListDefaultData> listPattern2 = Rxn<ListDefaultData>();

  final HrAutocompleteTextController _autocompleteTextController =
      HrAutocompleteTextController();
  final patternEditingController = TextEditingController();
  final patternEditingController2 = TextEditingController();
  String userUid = "hrhr";

  @override
  Future<void> onInit() async {
    listPattern.value = await _autocompleteTextController.fetchDefaultData(
        key: 'pattern', userUid: userUid);
    listPattern2.value = await _autocompleteTextController.fetchDefaultData(
        key: 'pattern2', userUid: userUid);
    print("${listPattern.value}");
    super.onInit();
  }

  Future<void> addData() async {
    listPattern.value = await _autocompleteTextController.verifyDefaultData(
        value: patternEditingController.text,
        listDefaultData: listPattern.value!,
        key: 'pattern',
        userUid: userUid);
    listPattern2.value = await _autocompleteTextController.verifyDefaultData(
        value: patternEditingController2.text,
        listDefaultData: listPattern2.value!,
        key: 'pattern2',
        userUid: userUid);
    print("${listPattern.value}");
  }
}
