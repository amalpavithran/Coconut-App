import 'package:coconut_app/models/user_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../injection_container.dart';
import 'cubit/group_cubit.dart';

class GroupPage extends StatelessWidget {
  final Object tag;
  const GroupPage({Key key, @required this.tag,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<GroupCubit>(),
      child: BlocConsumer<GroupCubit,GroupState>(
          builder: (context, state) {
            if(state is GroupInitial){
              return Scaffold(
                body: CustomScrollView(slivers: <Widget>[
                  SliverAppBar(leading: Hero(tag: tag,child: CircleAvatar(),),)
                ],),
              );
            }
          }, listener: (context, state) {}),
    );
  }
}
