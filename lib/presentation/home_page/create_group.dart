import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/home_cubit.dart';

class CreateGroupPage extends StatefulWidget {
  CreateGroupPage({Key key}) : super(key: key);

  @override
  _CreateGroupPageState createState() => _CreateGroupPageState();
}

class _CreateGroupPageState extends State<CreateGroupPage> {
  String _groupName, _groupDesc;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 10.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                textCapitalization: TextCapitalization.characters,
                validator: (value) {
                  if (value.isNotEmpty) {
                    return null;
                  } else {
                    return "Enter a valid group name";
                  }
                },
                onSaved: (String value) {
                  this._groupName = value;
                },
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    labelText: "Group Name",
                    border: OutlineInputBorder()),
              ),
              TextFormField(
                textCapitalization: TextCapitalization.characters,
                validator: (value) {
                  if (value.isNotEmpty) {
                    return null;
                  } else {
                    return "Enter a valid description";
                  }
                },
                onSaved: (String value) {
                  this._groupDesc = value;
                },
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    labelText: "Group description",
                    border: OutlineInputBorder()),
              ),
              Container(
                  height: 50,
                  width: double.infinity,
                  child: RaisedButton(
                    child: Text("Join Group",
                        style: TextStyle(color: Colors.white)),
                    color: Colors.green,
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        BlocProvider.of<HomeCubit>(context).createGroup(_groupName, _groupDesc);
                      }
                    },
                  ))
            ],
          )),
    );
  }
}
