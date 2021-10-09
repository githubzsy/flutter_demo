import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

main(List<String> args) {
  runApp(const MaterialApp(
      title: '示例',
      home: TodoList(
        todos: [
          Todo(name: '吃饭'),
          Todo(name: '睡觉'),
          Todo(name: '打豆豆'),
        ],
      )));
}

/// 一个应做项目
class Todo {
  const Todo({required this.name});

  final String name;
}

typedef ChangedCallback = Function(Todo todo, bool add);

class TodoListItem extends StatelessWidget {
  TodoListItem({
    required this.todo,
    required this.onChanged,
  }) : super(key: ObjectKey(todo));

  final Todo todo;
  final ChangedCallback onChanged;

  Color _getColor(BuildContext context) {
    // The theme depends on the BuildContext because different
    // parts of the tree can have different themes.
    // The BuildContext indicates where the build is
    // taking place and therefore which theme to use.

    return Theme.of(context).primaryColor;
  }

  TextStyle? _getTextStyle(BuildContext context) {
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        onChanged(todo, false);
      },
      leading: CircleAvatar(
        // 动态计算背景颜色
        backgroundColor: _getColor(context),
        child: Text(todo.name[0]),
      ),
      title: Text(
        todo.name,
        // 动态计算字体
        style: _getTextStyle(context),
      ),
    );
  }
}

class TodoList extends StatefulWidget {
  const TodoList({required this.todos, Key? key}) : super(key: key);

  final List<Todo> todos;

  @override
  State<StatefulWidget> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  _onPressed() {
    String text = _textField.controller!.text;
    Todo todo = Todo(name: text);
    _handleChanged(todo, true);
  }

  void _handleChanged(Todo todo, bool add) {
    setState(() {
      if (add) {
        widget.todos.add(todo);
      } else {
        widget.todos.remove(todo);
      }
    });
  }

  final TextField _textField = TextField();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Shopping List'),
        ),
        body: Column(
          children: [
            Row(
              children: [
                Expanded(child: _textField, flex: 3),
                Expanded(
                    child: ElevatedButton(
                        onPressed: _onPressed, child: const Text('添加')),
                    flex: 1)
              ],
            ),
            Expanded(
                child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              children: widget.todos.map((Todo todo) {
                return TodoListItem(
                  todo: todo,
                  // inCart变化时
                  onChanged: _handleChanged,
                );
              }).toList(),
            ))
          ],
        ));
  }
}
