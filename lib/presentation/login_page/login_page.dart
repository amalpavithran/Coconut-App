import 'package:coconut_app/auth_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

import '../../injection_container.dart';
import 'cubit/login_cubit.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() { 
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => sl<LoginCubit>(),
        child: Stack(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Image.asset('assets/splash.png',fit: BoxFit.cover),
            ),
            Align(
              alignment: Alignment.bottomCenter - Alignment(0, 0.15),
              child: BlocConsumer<LoginCubit, LoginState>(
                builder: (context, state) {
                  if (state is LoginLoading) {
                    return CircularProgressIndicator();
                  } else {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: SignInButton(Buttons.Google, onPressed: () {
                            BlocProvider.of<LoginCubit>(context).login();
                          })),
                    );
                  }
                },
                listener: (BuildContext context, LoginState state) {
                  if(state is LoginInitial){
                    BlocProvider.of<LoginCubit>(context).silentLogin();
                  }
                  if (state is LoginFailure) {
                    Scaffold.of(context)
                        .showSnackBar(SnackBar(content: Text(state.message)));
                  } else if (state is LoginSuccess) {
                    Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text("Login Success")));
                    Navigator.popAndPushNamed(context, '/homepage');
                  }
                },
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
