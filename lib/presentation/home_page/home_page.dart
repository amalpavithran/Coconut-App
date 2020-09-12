import 'package:coconut_app/models/pay_details.dart';
import 'package:coconut_app/payment_repo.dart';
import 'package:coconut_app/presentation/home_page/create_group_page.dart';
import 'package:coconut_app/presentation/home_page/join_group_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../injection_container.dart';
import '../styles.dart';
import 'cubit/home_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
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
        create: (context) => sl<HomeCubit>(),
        child: SingleChildScrollView(
          child: BlocConsumer<HomeCubit, HomeState>(
            listener: (context, state) {},
            builder: (context, state) {
              return Column(
                children: <Widget>[
                  buildCreateNewGroupBtn(context),
                  buildMakePaymentBtn(),
                  _buildForm(state),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text("Recents", style: title),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildForm(HomeState state) {
    if (state is ShowCreateGroup) {
      return CreateGroupPage();
    } else if (state is ShowJoinGroup) {
      return JoinGroup();
    } else {
      return Container();
    }
  }

  Widget buildMakePaymentBtn() {
    return RaisedButton(
      color: Colors.blue[200],
      child: Text(
        "Make Payment",
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {
        sl<PaymentRepositoryImpl>().initiatePayment(
            PaymentDetails(
                recieverUpiID: 'amal110100@oksbi',
                recieverName: 'Amal Pavithran',
                transactionNote: 'Testing',
                amount: 1),
            'test');
      },
    );
  }

  Widget buildCreateNewGroupBtn(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
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
                BlocProvider.of<HomeCubit>(context).createGroupInit();
              }),
          RaisedButton(
            color: Colors.blue[200],
            child: Text(
              "Join a Group",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              BlocProvider.of<HomeCubit>(context).joinGroupInit();
            },
          )
        ],
      ),
    );
  }
}
