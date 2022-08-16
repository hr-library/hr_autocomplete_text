import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';

import '../hr_autocomplete_text.dart';
import '../model/get_storage_key.dart';

class FirestoreUtils {
  static final FirebaseFirestore _client = FirebaseFirestore.instance;

  static final collectionDefaultData = _client
      .collection("defaultData")
      .doc(GetStorage().read(GetStorageKey.platform))
      .collection('hr');

  //***************DefaultData*******************
  Future<void> insertDefaultDataItem(Map<String, dynamic> hrModel) async {
    await collectionDefaultData.doc(hrModel['key']).set(hrModel);
  }

  Future<void> editDefaultDataItem(Map<String, dynamic> hrModel) async {
    await collectionDefaultData.doc(hrModel['key']).update(hrModel);
  }

  Future<List<String>> fetchDefaultData(String key) async {
    List<String> list = [];
    try {
      var documentSnapshot =
          await collectionDefaultData.where('key', isEqualTo: key).get();
      List<QueryDocumentSnapshot<Map<String, dynamic>>> docs =
          documentSnapshot.docs;
      docs.first.data()['list'].forEach((element) {
        list.add(element);
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return list;
  }
}
