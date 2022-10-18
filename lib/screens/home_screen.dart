import 'package:bloodzen/providers/user_provider.dart';
import 'package:bloodzen/resources/auth_methods.dart';
import 'package:bloodzen/responsive/mobile_screen_layout.dart';
import 'package:bloodzen/responsive/responsive_layout_screen.dart';
import 'package:bloodzen/responsive/web_screen_layout.dart';
import 'package:bloodzen/screens/add_details_screen.dart';
import 'package:bloodzen/screens/details_screen.dart';
import 'package:bloodzen/screens/login_screen.dart';
import 'package:bloodzen/screens/profile_screen.dart';
import 'package:bloodzen/utils/colors.dart';
import 'package:bloodzen/widgets/request_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import '../utils/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<User> UserData;
  String bloodGrpData = 'initial';
  @override
  void initState() {
    super.initState();
    AuthMethods().getUserDetails().then((value) {
      bloodGrpData = value.bloodGrp;
    });
  }

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;
    if (bloodGrpData == "example") {
      return AddDetailsScreen();
    } else {
      return Scaffold(
          appBar: AppBar(
            centerTitle: false,
            automaticallyImplyLeading: false,
            title: Image.asset(
              'assets/bloodzen.jpg',
              height: 32,
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ProfileScreen(),
                    ),
                  );
                },
                icon: Icon(Icons.person),
              ),
            ],
          ),
          body: Container(
            margin: EdgeInsets.only(top: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Requests in your city",
                  style: TextStyle(fontSize: 20),
                ),
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('requests')
                      .snapshots(),
                  builder: (context,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                          snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return ListView.separated(
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(8),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int index) => Card(
                        child: Container(
                          height: 120,
                          color: Color.fromARGB(255, 56, 55, 55),
                          child: Row(
                            children: [
                              Center(
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Expanded(
                                    child: Image.network(snapshot
                                        .data!.docs[index]
                                        .data()['profImage']),
                                    flex: 2,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.topLeft,
                                  child: Column(
                                    children: [
                                      Expanded(
                                        flex: 5,
                                        child: ListTile(
                                          title: Text(
                                            snapshot.data!.docs[index]
                                                .data()['username'],
                                          ),
                                          subtitle: Text(
                                            snapshot.data!.docs[index]
                                                .data()['description'],
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 5,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            TextButton(
                                              child: Text("Details"),
                                              onPressed: () =>
                                                  Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      DetailsScreen(
                                                    snap: snapshot
                                                        .data!.docs[index]
                                                        .data(),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 8,
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                flex: 8,
                              ),
                            ],
                          ),
                        ),
                        elevation: 8,
                        margin: EdgeInsets.all(10),
                      ),
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(),
                    );
                  },
                ),
              ],
            ),
          ));
    }
  }
}
