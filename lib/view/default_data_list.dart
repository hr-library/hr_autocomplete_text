part of '../hr_autocomplete_text.dart';

class DefaultDataListScaffold extends StatelessWidget {
  final List<List<String>> listDefaultData;
  final List<String> listKey;
  DefaultDataListScaffold({
    required this.listDefaultData,
    required this.listKey,
    Key? key,
  }) : super(key: key);

  final HrAutocompleteTextController _autocompleteTextController =
      Get.put(HrAutocompleteTextController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Données par défaut'),
        actions: [
          IconButton(
              onPressed: () {
                _autocompleteTextController.updateScreen();
              },
              icon: const Icon(Icons.update)),
        ],
      ),
      body: DefaultDataList(
        listDefaultData: listDefaultData,
        listKey: listKey,
      ),
    );
  }
}

class DefaultDataList extends StatelessWidget {
  final List<List<String>> listDefaultData;
  final List<String> listKey;
  DefaultDataList({
    required this.listDefaultData,
    required this.listKey,
    Key? key,
  })  : assert(listDefaultData.length == listKey.length,
            'listDefaultData and listKey must have the same length'),
        super(key: key);

  final HrAutocompleteTextController _autocompleteTextController =
      Get.put(HrAutocompleteTextController());

  @override
  Widget build(BuildContext context) {
    return _listTableTransaction();
  }

  Widget _listTableTransaction() {
    return ListView(
      children: _getTableFromMap(),
    );
  }

  List<Widget> _getTableFromMap() {
    List<Widget> list = [];
    int i = 0;
    for (List<String> element in listDefaultData) {
      element.sort((a, b) => a.compareTo(b));
      list.add(ExpansionTile(
        title: Text(listKey[i]),
        children: <Widget>[
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: _listViewBuilder(element, i),
          ),
        ],
      ));
      i++;
    }
    return list;
  }

  Widget _listViewBuilder(List<String> allData, int keyIndex) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: allData.length,
      itemBuilder: (BuildContext context, int index) {
        String data = allData[index];
        return _card(data, index, keyIndex, allData);
      },
    );
  }

  Widget _card(String data, int index, int keyIndex, List<String> allData) {
    return Card(
      elevation: 0,
      child: GFListTile(
        onTap: () {},
        title: Text(data),
        description: Text(index.toString()),
        icon: Row(
          children: [
            IconButton(
                onPressed: () {
                  _autocompleteTextController.showDialogEdit(
                    key: listKey[keyIndex],
                    value: data,
                    listDefaultData: allData,
                  );
                },
                icon: const Icon(Icons.edit)),
            IconButton(
                onPressed: () {
                  _autocompleteTextController.showDialogDelete(
                    value: data,
                    listDefaultData: allData,
                    key: listKey[keyIndex],
                  );
                },
                icon: const Icon(Icons.delete)),
          ],
        ),
      ),
    );
  }
}
