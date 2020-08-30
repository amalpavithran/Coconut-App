import 'package:coconut_app/auth_repo.dart';
import 'package:coconut_app/presentation/cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => LoginCubit(AuthRepositoryImpl()),
        child: Form(
          key: _formKey,
          child: Stack(
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Placeholder(),
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
                          child: SignInButton(Buttons.Google, onPressed: (){
                            BlocProvider.of<LoginCubit>(context).login();
                          })
                        ),
                      );
                    }
                  },
                  listener: (BuildContext context, LoginState state) {
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
      ),
    );
  }
}
