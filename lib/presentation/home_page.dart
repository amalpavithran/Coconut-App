import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    onPressed: null),
              ),
            ])
      ],
    ));
  }
}
