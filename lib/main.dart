import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import './pages/home_page.dart';
import './scoped_models/scoped_todo.dart';
import './pages/edit_todo.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ScopedTodo model = ScopedTodo();
    return ScopedModel(
      model: model,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Todo',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        routes: {
          '/': (BuildContext context) => HomePage(),
          'editTodo': (BuildContext context) => EditTodo(),
        },
      ),
    );
  }
}
