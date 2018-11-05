import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../scoped_models/scoped_todo.dart';
import '../../widgets/todo/todo_card.dart';

class TodoList extends StatelessWidget {
  Widget _buildDismissible(BuildContext context, ScopedTodo model, int index) {
    return Dismissible(
      key: Key(model.allTodos[index].id.toString()),
      direction: DismissDirection.endToStart,
      onDismissed: (DismissDirection direction) {
        myOnDismissed(direction, context, model, index);
      },
      background: Container(
        padding: EdgeInsets.symmetric(vertical: 5.0),
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(8.0),
                  topRight: Radius.circular(8.0)),
              color: Colors.red,
            ),
            padding: EdgeInsets.only(right: 32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Icon(Icons.delete_sweep, color: Colors.white),
                ),
                Text(
                  "Remove",
                  style: TextStyle(color: Colors.white),
                )
              ],
            )),
      ),
      child: TodoCard(index),
    );
  }

  void myOnDismissed(DismissDirection direction, BuildContext context,
      ScopedTodo model, int index) {
    if (direction == DismissDirection.endToStart) {
      Scaffold.of(context).hideCurrentSnackBar();
      model.selectTodo(model.allTodos[index].id);
      model.deleteTodo().then((_) {
        model.getDatas();
      });

      Scaffold.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 1),
          content: Text("One Item Removed"),
          action: SnackBarAction(
            label: '',
            onPressed: () {},
          ),
        ),
      );
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ScopedTodo>(
      builder: (BuildContext context, Widget child, ScopedTodo model) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 0.0),
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            itemCount: model.allTodos.length,
            itemBuilder: (BuildContext context, int index) {
              return _buildDismissible(context, model, index);
            },
          ),
        );
      },
    );
  }
}
