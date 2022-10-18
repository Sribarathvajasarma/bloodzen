import 'package:bloodzen/screens/UserDetailScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();
  bool isShowUsers = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: TextFormField(
            controller: searchController,
            decoration: const InputDecoration(
                labelText: 'search for users with blood group you need'),
            onFieldSubmitted: (String _) {
              setState(() {
                isShowUsers = true;
              });
            },
          ),
        ),
      ),
      body: isShowUsers
          ? FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('users')
                  .where('bloodGrp', isEqualTo: searchController.text)
                  .get(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if ((snapshot.data! as dynamic).docs.length == 0) {
                  return Text("No Search results found");
                } else {
                  return ListView.builder(
                    itemCount: (snapshot.data! as dynamic).docs.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: EdgeInsets.all(10),
                        color: Color.fromARGB(255, 56, 55, 55),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        shadowColor: Colors.grey,
                        elevation: 10,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(
                                  (snapshot.data! as dynamic).docs[index]
                                      ['photoUrl'],
                                ),
                                radius: 20,
                              ),
                              title: Text(
                                (snapshot.data! as dynamic).docs[index]
                                    ['username'],
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                    child: Text("Details"),
                                    onPressed: () => Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                UserDetailScreen(
                                              photoUrl:
                                                  (snapshot.data! as dynamic)
                                                      .docs[index]['photoUrl'],
                                              name: (snapshot.data! as dynamic)
                                                  .docs[index]['username'],
                                              bloodGrp:
                                                  (snapshot.data! as dynamic)
                                                      .docs[index]['bloodGrp'],
                                              city: (snapshot.data! as dynamic)
                                                  .docs[index]['city'],
                                              mobile:
                                                  (snapshot.data! as dynamic)
                                                      .docs[index]['mobile'],
                                            ),
                                          ),
                                        )),
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            )
          : Text("You can search requests using blood groups or cities"),
    );
  }
}
