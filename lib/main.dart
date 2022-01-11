import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:new_vanish_native/ui/todo_list_view.dart';

void main() {
  runApp(new MaterialApp(home: new Vanish()));
}

class Vanish extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vanish',
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en'),
        const Locale('ja'),
      ],
      theme: ThemeData(
        primarySwatch:Colors.blue,
      ),
      home: TodoList(),
    );
  }
}
