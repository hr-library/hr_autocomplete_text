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
      .doc(GetStorage().read(GetStorageKey.platform));

  //***************DefaultData*******************
  Future<void> insertDefaultDataItem(ListDefaultData hrModel) async {
    await collectionDefaultData
        .collection(hrModel.userUid)
        .doc(hrModel.key)
        .set(hrModel.toJson());
  }

  Future<void> editDefaultDataItem(ListDefaultData hrModel) async {
    await collectionDefaultData
        .collection(hrModel.userUid)
        .doc(hrModel.key)
        .update(hrModel.toJson());
  }

  Future<ListDefaultData> fetchDefaultData(String key, String userUid) async {
    try {
      var documentSnapshot = await collectionDefaultData
          .collection(userUid)
          .where('key', isEqualTo: key)
          .get();
      List<QueryDocumentSnapshot<Map<String, dynamic>>> docs =
          documentSnapshot.docs;
      return ListDefaultData.fromJson(docs[0].data());
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      ListDefaultData listDefaultData =
          ListDefaultData(key: key, list: [], userUid: userUid);
      return listDefaultData;
    }
  }
}
