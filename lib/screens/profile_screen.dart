import 'package:bloodzen/resources/firestore_method.dart';
import 'package:bloodzen/screens/edit_details_screen.dart';
import 'package:bloodzen/screens/edit_profile_screen.dart';
import 'package:bloodzen/screens/home_screen.dart';
import 'package:bloodzen/utils/utils.dart';
import 'package:bloodzen/widgets/button_widget.dart';
import 'package:bloodzen/widgets/numbers_widget.dart';
import 'package:flutter/material.dart';
import 'package:bloodzen/widgets/profile_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bloodzen/screens/details_screen.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import '../providers/user_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  void buttonPress() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EditProfilePage(),
      ),
    );
  }

  void DeleteRequest(String rid) async {
    try {
      String res = await FirestoreMethods().deletePost(rid);
      if (res == 'success') {
        showSnackBar('Request removed', context);
      } else {
        showSnackBar(res, context);
      }
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text('Profile'),
        ),
        body: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            ProfileWidget(
              imagePath: user.photoUrl,
              onClicked: () async {},
            ),
            const SizedBox(
              height: 24,
            ),
            buildName(user.username, user.email),
            const SizedBox(height: 14),
            Center(child: buildUpgradeButton()),
            const SizedBox(height: 14),
            NumbersWidget(),
            const SizedBox(height: 48),
            buildAbout(user.bio),
            const SizedBox(height: 20),
            Text(
              "Your requests",
              style: TextStyle(fontSize: 20),
            ),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('requests')
                  .where("username", isEqualTo: user.username)
                  .snapshots(),
              builder: (context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
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
                                child: Image.network(snapshot.data!.docs[index]
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
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        TextButton(
                                            child: Text("Edit"),
                                            onPressed: () => {
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          EditDetailScreen(
                                                              snap: snapshot
                                                                  .data!
                                                                  .docs[index]
                                                                  .data()),
                                                    ),
                                                  )
                                                }),
                                        TextButton(
                                            child: Text("delete"),
                                            onPressed: () => DeleteRequest(
                                                snapshot.data!.docs[index]
                                                    .data()['requestId'])),
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
        ));
  }

  Widget buildName(String name, String email) => Column(
        children: [
          Text(
            name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            email,
            style: TextStyle(color: Colors.grey),
          )
        ],
      );

  Widget buildUpgradeButton() => ButtonWidget(
        text: 'Edit profile',
        onClicked: buttonPress,
      );

  Widget buildAbout(String about) => Container(
        padding: EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              about,
              style: TextStyle(fontSize: 16, height: 1.4),
            ),
          ],
        ),
      );
}
