import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

/// Table布局简单示例
class MyTable extends StatelessWidget {
  const MyTable({Key? key}) : super(key: key);

  void _onPressed() {}

  @override
  Widget build(BuildContext context) {
    var edgeInsets = const EdgeInsets.all(16.0);
    var headerStyle = const TextStyle(fontSize: 22);

    var t = Table(
        border: TableBorder.all(),
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          TableRow(children: [
            TableCell(
                child: Container(
              color: Colors.grey,
              child: Text('不良原因', style: headerStyle),
              padding: edgeInsets,
            )),
            TableCell(
                child: Container(
              color: Colors.grey,
              child: Text('不良原因描述', style: headerStyle),
              padding: edgeInsets,
            )),
            TableCell(
                child: Container(
              color: Colors.grey,
              child: Text('不良原因组', style: headerStyle),
              padding: edgeInsets,
            )),
            TableCell(
                child: Container(
              color: Colors.grey,
              child: Text('不良原因组描述', style: headerStyle),
              padding: edgeInsets,
            )),
            TableCell(
                child: Container(
              color: Colors.grey,
              child: Text('操作列', style: headerStyle),
              padding: edgeInsets,
            ))
          ])
        ]);

    for (var element in items) {
      var row = TableRow(children: [
        TableCell(
            child: Container(
                padding: edgeInsets,
                child: Text(element['ReasonName']!.toString()))),
        TableCell(
            child: Container(
                padding: edgeInsets,
                child: Text(element['ReasonDescription']!.toString()))),
        TableCell(
            child: Container(
                padding: edgeInsets,
                child: Text(element['GroupName']!.toString()))),
        TableCell(
            child: Container(
                padding: edgeInsets,
                child: Text(element['GroupDescription']!.toString()))),
        TableCell(
            child: Container(
                padding: edgeInsets,
                child: ElevatedButton(
                  onPressed: _onPressed,
                  child: const Text('删除'),
                ))),
      ]);
      t.children.add(row);
    }

    return t;
  }
}

/// This is the main application widget.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = '表格布局示例';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: const MyTable(),
      ),
    );
  }
}

List<dynamic> items = <dynamic>[];
main(List<String> args) async {
  var url = Uri.http("10.6.1.116:8001",
      "/api/v2/DIMS/Q10/PAD/GetLossReasonsBySpecCode", {"specCode": "ZJJP002"});
  // Await the http get response, then decode the json-formatted response.
  var response = await http.post(url);
  if (response.statusCode == 200) {
    var jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;

    items = jsonResponse['data'] as List<dynamic>;

    runApp(const MyApp());
  } else {
    print('Request failed with status: ${response.statusCode}.');
  }
}
