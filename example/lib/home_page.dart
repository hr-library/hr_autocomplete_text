import 'package:example/home_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hr_autocomplete_text/hr_autocomplete_text.dart';
import 'package:text_field/text_field.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final HomePageController _homePageController = Get.put(HomePageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: [
          IconButton(
              onPressed: () {
                Get.to(DefaultDataListScaffold(
                  listDefaultData: [
                    Get.put(HomePageController()).listPattern.value,
                    Get.put(HomePageController()).listPattern2.value,
                  ],
                  listKey: const ['pattern', 'pattern2'],
                ));
              },
              icon: const Icon(Icons.list))
        ],
      ),
      body: Center(
        child: Column(
          children: [
            const Text('Bem vindo ao Flutter!!!'),
            const SizedBox(height: 20),
            Obx(() => HrCustomAutocompleteTextFormField(
                  labelText: 'Motif 1',
                  controller: _homePageController.patternEditingController,
                  suggestions: _homePageController.listPattern.value,
                  textInputType: TextInputType.text,
                )),
            const SizedBox(height: 20),
            Obx(() => HrCustomAutocompleteTextFormField(
                  labelText: 'Motif 2',
                  controller: _homePageController.patternEditingController2,
                  suggestions: _homePageController.listPattern2.value,
                  textInputType: TextInputType.text,
                )),
            TextButton(
                onPressed: () async {
                  await _homePageController.addData();
                },
                child: const Text('Enregistrer')),
          ],
        ),
      ),
    );
  }
}
