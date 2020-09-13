import 'package:coconut_app/models/user.dart';
import 'package:coconut_app/presentation/account_page/cubit/account_cubit.dart';
import 'package:coconut_app/presentation/account_page/cubit/user_details_cubit.dart';
import 'package:coconut_app/user_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../injection_container.dart';

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
