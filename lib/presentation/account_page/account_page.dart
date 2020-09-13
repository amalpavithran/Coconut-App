import 'dart:math';

import 'package:coconut_app/presentation/account_page/cubit/account_cubit.dart';
import 'package:coconut_app/presentation/account_page/user_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../injection_container.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => sl<AccountCubit>(),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              title: Text('My Account'),
              expandedHeight: 200,
              flexibleSpace: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[UserDetailsCard()],
              ),
            ),
            buildRecentTransactions()
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter buildRecentTransactions() {
    Widget textColor() {
      final generator = Random();
      final value =
          generator.nextDouble()*generator.nextInt(100) * (-1 * (generator.nextBool() ? -1 : 1));
      MaterialColor color;
      String prefix;
      if (value < 0) {
        color = Colors.red;
        prefix = '';
      } else {
        color = Colors.green;
        prefix = '+';
      }
      return Text(prefix + value.toStringAsFixed(2), style: TextStyle(color: color));
    }

    final items = List.generate(
      4,
      (index) => Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              CircleAvatar(),
              textColor(),
            ],
          ),
        ),
      ),
    );
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[Text("Recent Transcations"), ...items],
        ),
      ),
    );
  }
}
