import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'API testing',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ApiTesting(),
    );
  }
}

class ApiTesting extends StatefulWidget {
  const ApiTesting({
    Key? key,
  }) : super(key: key);

  @override
  State<ApiTesting> createState() => ApiTestingState();
}

class ApiTestingState extends State<ApiTesting> {
  Future getUSerData() async {
    var response =
        await http.get(Uri.https('jsonplaceholder.typicode.com', 'posts'));
    var jsonData = jsonDecode(response.body);

    List<User> users = [];

    for (var u in jsonData) {
      User user = User(u['name'], u['email'], u['username']);
      users.add(user);
    }
    print(users.length);
    return users;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API Testing'),
      ),
      body: Card(
        child: FutureBuilder(
          future: getUSerData(),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return const Center(
                child: Text("Loading"),
              );
            } else {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, i) {
                    return ListTile(
                      title: Text(snapshot.data[i].name),
                      subtitle: Text(snapshot.data[i].email),
                    );
                  });
            }
          },
        ),
      ),
    );
  }
}

class User {
  final String name, email, userName;

  User(this.name, this.email, this.userName);
}
