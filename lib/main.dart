import './models/user.dart';
import 'package:flutter/material.dart';
import './utils/database_helper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

List _users;

void main() async {

  var db = new DatabaseHelper();

  // int savedUser = await db.saveUser(new User("Ana", "anita"));

  // print("$savedUser");

  _users = await db.getAllUsers();

  for (int i = 0; i < _users.length; i++) {
    User user = User.map(_users[i]);
    print("Username: ${user.userName}");
  }

  //couting 
  int count = await db.getCount();
  print("rows total: $count");

  // delete a user



  runApp(new MaterialApp(
    title: 'Database demo',
    home: new Home(),
  ));
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Database'), 
        centerTitle: true,
        backgroundColor: Colors.lightGreen,
      ),

      body: new Container(
        child: new ListView.builder(
          itemCount: _users.length,
          itemBuilder: (_, int position) {
            return new Card(
              color: Colors.white,
              elevation: 2.0,
              child: new ListTile(
                title: new Text("User: ${User.fromMap(_users[position]).userName}"),
                subtitle: new Text("Id: ${User.fromMap(_users[position]).id}"),
              ),
            );
          },
        ),
      ),
    );
  }
}