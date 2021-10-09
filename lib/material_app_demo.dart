import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'MaterialApp layout demo',
        home: Scaffold(
            appBar: AppBar(title: const Text('这是标题')),
            body: Center(
                child: Container(
              // 红色背景
              color: const Color.fromARGB(100, 255, 0, 0),
              // padding 16像素
              padding: const EdgeInsets.all(16.0),
              child: Row(
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Column(children: const [Text('第一列01'), Text('第一列02'), Text('第一列03')]),
                  Column(children: const [
                    Text('第二列01'),
                    Icon(Icons.sentiment_very_satisfied),
                    Text('第二列03')
                  ]),
                  Column(
                    children:const [
                      FlutterLogo(),
                      Expanded(
                        child: Text(
                            "Flutter's hot reload helps you quickly and easily experiment ",
                            // 文字方向：从右向左
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                              fontSize: 32,
                              // 字体颜色
                              color: Colors.blue,
                              // 超出时显示方式
                              overflow: TextOverflow.ellipsis
                            ),),
                      ),
                      Icon(Icons.sentiment_very_satisfied_outlined),
                    ],
                  )
                ],
              ),
            ))));
  }
}

main(List<String> args) {
  runApp(const MyApp());
}
