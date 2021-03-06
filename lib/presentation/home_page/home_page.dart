import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../injection_container.dart';
import '../../models/pay_details.dart';
import '../../models/user.dart';
import '../../models/user_group.dart';
import '../account_page/account_page.dart';
import '../group_page/group_page.dart';
import '../repos/payment_repo.dart';
import '../styles.dart';
import 'create_group.dart';
import 'cubit/home_cubit.dart';
import 'join_group.dart';

class HomePage extends StatefulWidget {
  final UserDetails userDetails;
  const HomePage(this.userDetails, {Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState(userDetails);
}

class _HomePageState extends State<HomePage> {
  final UserDetails userDetails;

  _HomePageState(this.userDetails);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => sl<HomeCubit>(),
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              title: Text("Coconut"),
              expandedHeight: 150,
              flexibleSpace: BlocBuilder<HomeCubit, HomeState>(
                  builder: (BuildContext context, state) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    buildGroupBtns(context, state),
                    // buildMakePaymentBtn(),
                    SizedBox(
                      height: 20,
                    )
                  ],
                );
              }),
              actions: actions(context),
            ),
            BlocConsumer<HomeCubit, HomeState>(
              listener: (context, state) {
                if (state is Logout) {
                  Navigator.of(context).popAndPushNamed('/login');
                }
              },
              builder: (context, state) {
                return SliverToBoxAdapter(
                  child: Column(
                    children: <Widget>[
                      buildForm(state),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text("Active Groups", style: title),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            buildActiveGroups()
          ],
        ),
      ),
    );
  }

  SliverGrid buildActiveGroups() {
    final tUserData = UserDetails(
        email: 'hemanth@gmail.com',
        name: 'Hemanth',
        photoURL: null,
        upiID: 'amal110100@oksbi');
    List<Map<UserDetails, double>> userdata = List.generate(4, (index) {
      final map = Map<UserDetails, double>();
      map[tUserData] = 0.0;
      return map;
    });
    final UserGroup userGroup =
        UserGroup('test', '1234', userdata, [], [], false);
    return SliverGrid.count(
      crossAxisCount: 4,
      crossAxisSpacing: 10,
      children: List<Widget>.generate(
        8,
        (index) => IconButton(
          icon: Hero(tag: index, child: CircleAvatar()),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => GroupPage(
                          tag: index,
                          userGroup: userGroup,
                        )));
          },
        ),
      ),
    );
  }

  List<Widget> actions(BuildContext context) {
    print(userDetails.photoURL);
    return <Widget>[
      IconButton(
        icon: Icon(Icons.exit_to_app),
        onPressed: () {
          BlocProvider.of<HomeCubit>(context).logout();
        },
      ),
      IconButton(
        iconSize: 40,
        icon: CircleAvatar(backgroundImage: NetworkImage(userDetails.photoURL)),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AccountPage(userDetails)));
        },
      ),
    ];
  }

  Widget buildForm(HomeState state) {
    if (state is ShowCreateGroup) {
      return CreateGroupPage();
    } else if (state is ShowJoinGroup) {
      return JoinGroup();
    } else {
      return Container();
    }
  }

  //TODO:Marked for Deletion
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

  Widget buildGroupBtns(BuildContext context, HomeState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        RaisedButton(
          color: Colors.green,
          child: Text(
            "Create Group",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            if (state is ShowCreateGroup)
              BlocProvider.of<HomeCubit>(context).reset();
            else
              BlocProvider.of<HomeCubit>(context).createGroupInit();
          },
        ),
        RaisedButton(
          color: Colors.blue[200],
          child: Text(
            "Join a Group",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            if (state is ShowJoinGroup)
              BlocProvider.of<HomeCubit>(context).reset();
            else
              BlocProvider.of<HomeCubit>(context).joinGroupInit();
          },
        )
      ],
    );
  }
}
