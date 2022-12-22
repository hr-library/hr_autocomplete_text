import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hr_autocomplete_text/model/get_storage_key.dart';

import 'home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyDx-z6rsjA7N6fG75TauvMGAhrPFCuvfrM",
          authDomain: "hr-test-48e7e.firebaseapp.com",
          projectId: "hr-test-48e7e",
          storageBucket: "hr-test-48e7e.appspot.com",
          messagingSenderId: "513998380685",
          appId: "1:513998380685:web:8f7a05fcfeb4a79ca4ccc4",
          measurementId: "G-8296595LTL"),
    );
  } else {
    await Firebase.initializeApp();
  }

  await GetStorage.init();
  GetStorage().write(GetStorageKey.platform, 'dev');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      home: HomePage(),
    );
  }
}
