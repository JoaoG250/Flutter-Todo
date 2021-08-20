import 'package:flutter/material.dart';

void main() {
  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Pendências',
      home: ListaTodo(),
    );
  }
}

class ListaTodo extends StatefulWidget {
  @override
  _StateTodo createState() => _StateTodo();
}

class _StateTodo extends State<ListaTodo> {
  final List<String> _listaTodo = <String>[];
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de Pendências')),
      body: ListView(children: _getTodos()),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showDialog(context),
        child: Icon(Icons.add),
      ),
    );
  }

  List<Widget> _getTodos() {
    final List<Widget> _widgetsTodo = <Widget>[];
    for (String titulo in _listaTodo) {
      _widgetsTodo.add(ListTile(title: Text(titulo)));
    }
    return _widgetsTodo;
  }

  void _adicionarTodo(String titulo) {
    setState(() {
      _listaTodo.add(titulo);
    });
    _textController.clear();
  }

  Future<void> _showDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Adicionar Pendência'),
          content: TextField(
            controller: _textController,
            decoration: const InputDecoration(hintText: 'Pendência'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                _adicionarTodo(_textController.text);
                Navigator.of(context).pop();
              },
              child: const Text('Adicionar'),
            ),
          ],
        );
      },
    );
  }
}
