import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../injection_container.dart';
import '../../models/user.dart';
import '../repos/user_repo.dart';
import 'cubit/account_cubit.dart';
import 'cubit/user_details_cubit.dart';

class UserDetailsCard extends StatefulWidget {
  UserDetailsCard({Key key}) : super(key: key);

  @override
  _UserDetailsCardState createState() => _UserDetailsCardState();
}

class _UserDetailsCardState extends State<UserDetailsCard> {
  UserDetails userDetails;
  @override
  void initState() {
    super.initState();
    userDetails = sl<UserRepository>().getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => sl<UserDetailsCubit>(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          buildUpiId(),
        ],
      ),
    );
  }

  buildUpiId() {
    TextEditingController _upiId;
    return BlocBuilder<UserDetailsCubit, UserDetailsState>(
      builder: (context, state) {
        if (state is UserDetailsInitial && userDetails.upiID == "null") {
          RaisedButton(
            child: Text('Set UPI ID'),
            color: Colors.red,
            onPressed: () {
              BlocProvider.of<UserDetailsCubit>(context).showEditBox();
            },
          );
        } else if (state is UserDetailsShowEdit) {
          return Row(
            children: <Widget>[
              TextFormField(
                controller: _upiId,
              ),
              RaisedButton(
                child: Text("Update"),
                onPressed: () {
                  BlocProvider.of<AccountCubit>(context).updateUpi(_upiId.text);
                },
              )
            ],
          );
        }
        return Text(userDetails.upiID);
      },
    );
  }
}
