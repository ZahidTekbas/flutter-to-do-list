import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodoList extends StatefulWidget {
  @override
  createState() => TodoListState();
}

class TodoListState extends State<TodoList> {
  String _title;
  List<String> _todoItems = [];
  List<String> _previousItems = [];

  Widget _buildTodoList() {
    return ListView.builder(
      itemBuilder: (context, index) {
        if (index < _todoItems.length) {
          return Dismissible(
            direction: DismissDirection.endToStart,
            key: Key(_todoItems[index]),
            background: Container(
              alignment: AlignmentDirectional.centerEnd,
              color: Colors.red,
              child: Padding(
                padding: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                child: Icon(Icons.delete_sweep, color: Colors.white),
              ),
            ),
            onDismissed: (direction) {
              setState(() {
                _todoItems.removeAt(index);
              });
            },
            child: AnimatedContainer(
              height: 40.0,
              decoration: BoxDecoration(
                border: Border.all(width: 1.5),
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: EdgeInsets.all(5.0),
              child: Row(
                children: <Widget>[
                  Text(
                    _todoItems[index],
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                    ),
                  )
                ],
              ),
              duration: Duration(seconds: 5),
              curve: Curves.bounceInOut,
            ),
          );
        }
      },
    );
  }


  Widget _noItem() {
    Widget card;
    if (_todoItems.length > 0) {
      card = _buildTodoList();
    } else{
      card = Container(
        child: Center(
          child: Text('No item found! Please add some.'),
        ),
      );
      }
    return card;
}

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Todo List')),
      body: _noItem(),
      floatingActionButton: FloatingActionButton(
        onPressed: _pushTodoScreen,
        tooltip: 'Add task',
        child: Icon(Icons.add),
        elevation: 20.0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0))),
      ),
    );
  }

  void _addItem(String task) {
    if (task.length > 0 || task.length == null) {
      setState(() {
        _todoItems.add(task);
      });
    }
  }

  void _pushTodoScreen() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Add a new task'),
        ),
        body: Column(children: [
          TextField(
            autofocus: true,
            onChanged: (value) {
              setState(() {
                _title = value;
              });
            },
            decoration: InputDecoration(
                labelText: 'Title for your task',
                contentPadding: const EdgeInsets.all(8.0)),
          ),
          RaisedButton(
              child: Text('Save'),
              onPressed: () {
                _addItem(_title);
                _title = '';
                Navigator.pop(context);
              })
        ]),
      );
    }));
  }
}
