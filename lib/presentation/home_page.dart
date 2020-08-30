import 'package:coconut_app/models/user.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<UserDetails> users = [
      UserDetails(
          email: "hemanth@gmail.com",
          name: "Hemanth",
          photoURL: null,
          groups: null)
    ];
    List<Widget> groupWids = [];
    for (var user in users) {
      groupWids.add(Card(
        child: Text(user.email),
      ));
    }
    Widget groupList = SingleChildScrollView(
      child: Column(
        children: groupWids,
      ),
    );

    return Scaffold(
        body: CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          title: Text('My Account'),
          expandedHeight: 150,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                iconSize: 35,
                icon: Icon(Icons.account_circle, color: Colors.white),
                onPressed: null,
              ),
            ),
          ],
        ),
      ],
    ));
  }
}
