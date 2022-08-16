import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetDialog {
  void showEdit({
    required String title,
    required TextEditingController controller,
    required VoidCallback? onConfirm,
  }) {
    Get.defaultDialog(
        title: title,
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: 'Enter a text',
          ),
        ),
        actions: [
          TextButton(
            onPressed: onConfirm,
            child: const Text('Ok'),
          )
        ]);
  }

  void showDelete({
    required String value,
    required VoidCallback? onConfirm,
  }) {
    Get.defaultDialog(
        title: 'Suppression',
        content: Text('Voullez vous supprimmer $value ?'),
        actions: [
          TextButton(
            onPressed: onConfirm,
            child: const Text('Ok'),
          )
        ]);
  }
}
