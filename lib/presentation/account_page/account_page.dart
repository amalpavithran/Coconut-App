import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../injection_container.dart';
import '../../models/user.dart';
import 'cubit/account_cubit.dart';
import 'user_details.dart';

class AccountPage extends StatelessWidget {
  final UserDetails userDetails;
  const AccountPage(this.userDetails, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => sl<AccountCubit>(),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              title: Text('My Account'),
              // floating: true,
              expandedHeight: 200,
              flexibleSpace: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[UserDetailsCard()],
              ),
              actions: <Widget>[
                IconButton(
                  iconSize: 40,
                  icon: CircleAvatar(
                      backgroundImage: NetworkImage(userDetails.photoURL)),
                  onPressed: () {},
                )
              ],
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
      final value = generator.nextDouble() *
          generator.nextInt(100) *
          (-1 * (generator.nextBool() ? -1 : 1));
      MaterialColor color;
      String prefix;
      if (value < 0) {
        color = Colors.red;
        prefix = '';
      } else {
        color = Colors.green;
        prefix = '+';
      }
      return Text(prefix + value.toStringAsFixed(2),
          style: TextStyle(color: color));
    }

    final items = List.generate(
      10,
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
