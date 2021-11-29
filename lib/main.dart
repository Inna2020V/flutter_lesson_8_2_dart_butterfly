import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Buterflies'),
          centerTitle: true,
        ),
        body: const ButterfliesList(),
      ),
    );
  }
}

class Butterfly {
  String name;
  String description;

  // ignore: unused_field
  static const List<String> _buterrflies = [
    'Annabella',
    'Duke',
    'Laurel',
    'Pearl',
    'Valeria',
  ];
  static const List<String> _buterrfliesDescription = [
    'Beautiful butterfly',
    'Amaizing butterfly',
    'Colourful butterfly',
    'Delicate butterfly',
    'DDelicate butterfly',
  ];
  Butterfly(this.name, this.description);

  static List<Butterfly> getClassList() {
    var _butterflyClassList = <Butterfly>[];
    for (int i = 0; i < _buterrflies.length; i++) {
      _butterflyClassList
          .add(Butterfly(_buterrflies[i], _buterrfliesDescription[i]));
    }
    return _butterflyClassList;
  }

  static bool isNameValid(String name) {
    return _buterrflies.contains(name);
  }

  static List<String> getPromptList() {
    return _buterrflies;
  }
}

class ButterfliesList extends StatefulWidget {
  const ButterfliesList({Key? key}) : super(key: key);

  @override
  _ButterfliesListState createState() => _ButterfliesListState();
}

class _ButterfliesListState extends State<ButterfliesList> {
  var _butterflyClassList = <Butterfly>[];
  // ignore: unused_field
  String _description = '';
  // ignore: prefer_final_fields
  var _controller = TextEditingController();
  int _selectedIndex = -1;
  int _getIndex(String name) {
    if (Butterfly.isNameValid(name)) {
      for (Butterfly b in _butterflyClassList) {
        if (b.name == name) return _butterflyClassList.indexOf(b);
      }
    }
    return -1;
  }

  @override
  void initState() {
    _butterflyClassList = Butterfly.getClassList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          TextField(
              controller: _controller,
              decoration: InputDecoration(
                  hintText: 'Write butterfly',
                  suffixIcon: PopupMenuButton(
                    onSelected: (String value) {
                      setState(() {
                        _controller.text = value;
                        _selectedIndex = _getIndex(value);
                        _description =
                            _butterflyClassList[_selectedIndex].description;
                      });
                    },
                    icon: const Icon(Icons.search),
                    itemBuilder: (BuildContext context) {
                      var _items = Butterfly.getPromptList();
                      return _items.map((String value) {
                        return PopupMenuItem(
                          value: value,
                          child: Text(value),
                        );
                      }).toList();
                    },
                  )),
              onSubmitted: (String value) {
                setState(() {
                  _selectedIndex = _getIndex(value);
                  if (_selectedIndex != -1) {
                    _description =
                        _butterflyClassList[_selectedIndex].description;
                  } else {
                    _description = 'This butterfly is not on the list';
                  }
                });
              }),
          const SizedBox(height: 10),
          Container(
            height: 100,
            child: ListView.separated(
              padding: const EdgeInsets.all(20),
              scrollDirection: Axis.horizontal,
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(height: 100, width: 10),
              itemCount: _butterflyClassList.length,
              itemBuilder: _createListView,
            ),
          ),
          const SizedBox(height: 10),
          Text(_description, style: const TextStyle(fontSize: 20))
        ],
      ),
    ));
  }

  Widget _createListView(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _description = _butterflyClassList[index].description;
          _selectedIndex = index;
        });
      },
      child: Container(
        child: Center(
          child: Text(
            "\u{1F98B}" + _butterflyClassList[index].name,
            style: const TextStyle(fontSize: 14),
          ),
        ),
        height: 100,
        width: 200,
        decoration: BoxDecoration(
            color: Colors.blue,
            border: Border.all(
                color:
                    index == _selectedIndex ? Colors.lightBlue : Colors.black26,
                width: 3),
            borderRadius: const BorderRadius.all(Radius.circular(20))),
      ),
    );
  }
}
