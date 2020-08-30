import 'package:coconut_app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

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
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                      color: Colors.green,
                      child: Text("Create New Group",style: TextStyle(color:Colors.white),),
                      onPressed: (){}),
                  RaisedButton(
                    color: Colors.blue[200],
                    child: Text("Join a Group",style: TextStyle(color:Colors.white),),
                    onPressed: (){

                    },
                  )
                ],
              ),
            ),
            groupList,
          ],
        ),
      ),
    );
  }
}
