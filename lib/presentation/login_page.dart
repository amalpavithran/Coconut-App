import 'package:coconut_app/auth_repo.dart';
import 'package:coconut_app/presentation/cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _phoneNumber;
  String _password;
  @override
  Widget build(BuildContext context) {
    final phoneNumber = Padding(
      padding: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 10.0),
      child: TextFormField(
        textCapitalization: TextCapitalization.characters,
        validator: (value) {
          if (value.length == 10) {
            return null;
          } else {
            return "Enter a valid phone number";
          }
        },
        onSaved: (String value) {
          this._phoneNumber = value;
        },
        decoration: InputDecoration(
            enabledBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
            labelText: "Roll Number",
            border: OutlineInputBorder()),
      ),
    );
    final password = Padding(
      padding: EdgeInsets.symmetric(vertical: 7.0, horizontal: 10.0),
      child: TextFormField(
        enabled: false,
        onSaved: (value) {
          this._password = value;
        },
        obscureText: true,
        keyboardType: TextInputType.visiblePassword,
        decoration: InputDecoration(
            enabledBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
            labelText: "Password",
            labelStyle: TextStyle(color: Colors.grey),
            border:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.grey))),
      ),
    );
    return Scaffold(
      body: BlocProvider(
        create: (context) => LoginCubit(AuthRepositoryImpl()),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              phoneNumber,
              password,
              BlocBuilder<LoginCubit, LoginState>(
                builder: (context, state) {
                  if (state is LoginLoading) {
                    return Container(
                      height: 50,
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return RaisedButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          BlocProvider.of<LoginCubit>(context)
                              .login(_phoneNumber, _password);
                        }
                      },
                      child: Text("Login"),
                    );
                  }
                },
              ),
              BlocListener<LoginCubit, LoginState>(
                listener: (BuildContext context, LoginState state) {
                  if (state is LoginFailure) {
                    Scaffold.of(context)
                        .showSnackBar(SnackBar(content: Text(state.message)));
                  }else if(state is LoginSuccess){
                    Scaffold.of(context).showSnackBar(SnackBar(content: Text("Login Success")));
                    //TODO: Implement Push to Home
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
