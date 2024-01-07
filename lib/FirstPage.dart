import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sarthakgupta_api_integration/Model.dart';
import 'package:http/http.dart' as http;

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  List<ItemsList> itemList = [];
  String?
      selectedItem; // To store the currently selected item in the DropdownButton

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (selectedItem == null && itemList.isNotEmpty) {
            selectedItem = itemList.first.id.toString();
          }
          return ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Container(
                    height: 150,
                    padding: const EdgeInsets.all(30),
                    color: Colors.black87,
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            'Id: ${(selectedItem != null && int.tryParse(selectedItem!) != null) ? itemList[int.parse(selectedItem!) - 1].id : "Empty"}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.white),
                          ),
                          Text(
                            'Name: ${(selectedItem != null && int.tryParse(selectedItem!) != null) ? itemList[int.parse(selectedItem!) - 1].name : "Empty"}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.white),
                          ),
                          Text(
                            'Mobile: ${(selectedItem != null && int.tryParse(selectedItem!) != null) ? itemList[int.parse(selectedItem!) - 1].mobile : "Empty"}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Center(
                    heightFactor: 5,
                    child: DropdownButton<String>(
                      value: selectedItem ??
                          itemList.first.id
                              .toString(), // Set a default value if selectedItem is null
                      onChanged: (String? value) {
                        setState(() {
                          selectedItem = value;
                        });
                      },
                      items: itemList.map((item) {
                        return DropdownMenuItem<String>(
                          value: item.id.toString(),
                          child: Text(item.name),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              );
            },
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Future<List<ItemsList>> getData() async {
    final response = await http.get(Uri.parse(
        "https://gist.githubusercontent.com/SarthakGupta2912/2cf3ca3fe5be87ab045deae6af5c8ce6/raw/Test2.json"));
    var data = jsonDecode(response.body.toString());
    itemList.clear();
    if (response.statusCode == 200) {
      for (Map<String, dynamic> index in data) {
        itemList.add(ItemsList.fromJson(index));
      }
    }

    return itemList;
  }
}
