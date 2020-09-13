import 'package:coconut_app/models/user_group.dart';
import 'package:coconut_app/presentation/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../injection_container.dart';
import 'cubit/group_cubit.dart';

class GroupPage extends StatelessWidget {
  final Object tag;
  final UserGroup userGroup;
  const GroupPage({
    Key key,
    @required this.tag,
    @required this.userGroup,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<GroupCubit>(),
      child: BlocConsumer<GroupCubit, GroupState>(
          builder: (context, state) {
            return Scaffold(
              body: CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    title: Hero(
                      tag: tag,
                      child: CircleAvatar(),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(height: 20),
                  ),
                  SliverToBoxAdapter(
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            Text("Summary",style: title),
                            SizedBox(height:20),
                            Text("Total Expense: " + ''),
                            SizedBox(height:10),
                          ],
                        ),
                      ),
                    ),
                  ),
                  buildParticipants(),
                ],
              ),
            );
          },
          listener: (context, state) {}),
    );
  }

  SliverToBoxAdapter buildParticipants() {
    return SliverToBoxAdapter(
      child: Container(
        height: 100,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: userGroup.groupInfo.length,
          itemBuilder: (context, index) {
            final key = userGroup.groupInfo[index].keys.toList()[0];
            final item = key;
            final value = userGroup.groupInfo[index][key];
            final icon =
                value > 0 ? Icons.arrow_drop_up : Icons.arrow_drop_down;
            final color = value > 0 ? Colors.green : Colors.red;
            return Container(
              height: 100,
              width: 90,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(),
                  Text(item.name),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        icon,
                        color: color,
                      ),
                      Text(value.toStringAsFixed(2),
                          style: TextStyle(color: color))
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
