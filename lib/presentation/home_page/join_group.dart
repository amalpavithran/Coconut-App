import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/home_cubit.dart';


class JoinGroup extends StatefulWidget {
  JoinGroup({Key key}) : super(key: key);

  @override
  _JoinGroupState createState() => _JoinGroupState();
}

class _JoinGroupState extends State<JoinGroup> {
  String _groupId;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 10.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                textCapitalization: TextCapitalization.characters,
                validator: (value) {
                  if (value.isNotEmpty) {
                    return null;
                  } else {
                    return "Enter a valid ID";
                  }
                },
                onSaved: (String value) {
                  this._groupId = value;
                },
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    labelText: "Group ID",
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
                        BlocProvider.of<HomeCubit>(context).joinGroup(_groupId);
                      }
                    },
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
