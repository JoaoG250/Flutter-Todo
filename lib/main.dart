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
      body: ListView(children: _getTodos(context)),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showDialog(context, _adicionarDialog(context)),
        child: Icon(Icons.add),
      ),
    );
  }

  List<Widget> _getTodos(BuildContext context) {
    final List<Widget> _widgetsTodo = <Widget>[];
    for (var i = 0; i < _listaTodo.length; i++) {
      _widgetsTodo.add(ListTile(
        title: Text(_listaTodo[i]),
        trailing: Wrap(
          children: [
            TextButton(
              onPressed: () {
                _showDialog(context, _editarDialog(context, i, _listaTodo[i]));
              },
              child: const Text('Editar'),
            ),
            TextButton(
              onPressed: () {
                _excluirTodo(i);
              },
              child: const Text('Remover'),
            ),
          ],
        ),
      ));
    }
    return _widgetsTodo;
  }

  void _adicionarTodo(String titulo) {
    setState(() {
      _listaTodo.add(titulo);
    });
    _textController.clear();
  }

  void _editarTodo(int index, String titulo) {
    setState(() {
      _listaTodo[index] = titulo;
    });
    _textController.clear();
  }

  void _excluirTodo(int index) {
    setState(() {
      _listaTodo.removeAt(index);
    });
  }

  Widget _adicionarDialog(BuildContext context) {
    _textController.clear();
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
  }

  Widget _editarDialog(BuildContext context, int index, String initialValue) {
    _textController.text = initialValue;
    return AlertDialog(
      title: const Text('Editar Pendência'),
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
            _editarTodo(index, _textController.text);
            Navigator.of(context).pop();
          },
          child: const Text('Editar'),
        ),
      ],
    );
  }

  Future<void> _showDialog(BuildContext context, Widget dialogWidget) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return dialogWidget;
      },
    );
  }
}
