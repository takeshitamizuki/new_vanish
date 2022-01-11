import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_vanish_native/ui/todo_add_view.dart';
import 'package:new_vanish_native/ui/todo_detail_view.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  // Todoリストのデータ
  late Map data;
  List todoList = [];
  int totalCount = 0;

  Future getTodoList() async {
    http.Response response = await http.get("http://localhost:8080/api/v1/todolist");
    data = json.decode(utf8.decode(response.bodyBytes));
    setState(() {
      todoList = data["data"]["todoList"];
      totalCount = data["data"]["totalCount"];
      print(todoList);
    });
  }

  @override
  void initState() {
    super.initState();
    getTodoList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {},
            icon: Icon(Icons.miscellaneous_services),
        ),
        title: Text('TODO一覧 ${this.totalCount}件'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.mode_edit),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: totalCount,
        itemBuilder: (context, index) {
          return Row(
            children: <Widget>[
              Card(
                margin: EdgeInsets.only(left: 10),
                child: Container(
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.center,
                  child: (() {
                    if (todoList[index]["todaySequences"] != null) {
                      return Text('Today');
                    } else {
                      return Text('');
                    }
                  })(),
                ),
              ),
              Card(
                margin: EdgeInsets.all(10),
                child: Container(
                  margin: EdgeInsets.all(5),
                  width: 310,
                  padding: EdgeInsets.all(20),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) {
                          return TodoDetail(todoList[index]["todoId"]);
                        }),
                      );
                    },
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              child: Text(todoList[index]["title"]),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 50),
                              child: Text(todoList[index]["endDate"].split(" ")[0]),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            for (int x = 0; x < todoList[index]["tags"].length; x++)
                              if (todoList[index]["tags"][x] != null)
                                Container(
                                  child: Text(todoList[index]["tags"][x]),
                                ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )
            ]
          );
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 30),
            child: FloatingActionButton(
              heroTag: 'addTodoLeft',
              child: Icon(Icons.add),
              onPressed: () async {
                // "push"で新規画面に遷移
                // リスト追加画面から渡される値を受け取る
                final newListText = await Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) {
                    // 遷移先の画面としてリスト追加画面を指定
                    return TodoAdd();
                  }),
                );
                if (newListText != null) {
                  // キャンセルした場合は newListText が null となるので注意
                  setState(() {
                    todoList.add(newListText);
                  });
                }
              },
            ),
          ),
          RaisedButton(
            child: const Text('OPEN'),
            color: Colors.white,
            textColor: Colors.black,
            onPressed: () {},
          ),
          RaisedButton(
            child: const Text('CLOSE'),
            color: Colors.white,
            textColor: Colors.black,
            onPressed: () {},
          ),
          Container(
            child: FloatingActionButton(
              heroTag: 'addTodoRight',
              child: Icon(Icons.add),
              onPressed: () async {
                // "push"で新規画面に遷移
                // リスト追加画面から渡される値を受け取る
                final newListText = await Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) {
                    // 遷移先の画面としてリスト追加画面を指定
                    return TodoAdd();
                  }),
                );
                if (newListText != null) {
                  // キャンセルした場合は newListText が null となるので注意
                  setState(() {
                    todoList.add(newListText);
                  });
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}