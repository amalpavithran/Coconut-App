import 'package:coconut_app/group_repo.dart';
import 'package:coconut_app/models/user.dart';
import 'package:coconut_app/presentation/cubit/home_cubit.dart';
import 'package:coconut_app/presentation/join_group_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    List<UserDetails> users = [
      UserDetails(
          email: "hemanth@gmail.com",
          name: "Hemanth",
          photoURL: null,
          groups: null),
      UserDetails(
          email: "amal@gmail.com", name: "Amal", photoURL: null, groups: null)
    ];
    List<Widget> groupWids = [];
    for (var user in users) {
      groupWids.add(Padding(
          padding: EdgeInsets.fromLTRB(0, 5, 5, 0),
          child: Card(
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: 40,
                child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(user.email),
                          Padding(
                            padding: EdgeInsets.only(left: 5),
                            child: Text(user.name),
                          ),
                          Spacer(),
                          Text("Amount")
                        ]))),
          )));
    }
    Widget groupList = SingleChildScrollView(
      child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: groupWids,
          )),
    );


    return Scaffold(
      appBar: AppBar(
        title: Text('My Account'),
        flexibleSpace: SizedBox(height: 200),
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
      body: BlocProvider(
        create: (context) => HomeCubit(Group()),
        child: SingleChildScrollView(
          child: BlocConsumer<HomeCubit, HomeState>(
            listener: (context, state) {},
            builder: (context, state) {
              return Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        RaisedButton(
                            color: Colors.green,
                            child: Text(
                              "Create New Group",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, '/creategroup');
                            }),
                        RaisedButton(
                          color: Colors.blue[200],
                          child: Text(
                            "Join a Group",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, '/joingroup');
                          },
                        )
                      ],
                    ),
                  ),
                  groupList,
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
