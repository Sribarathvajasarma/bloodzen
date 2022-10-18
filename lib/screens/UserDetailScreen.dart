import 'package:flutter/material.dart';

class UserDetailScreen extends StatelessWidget {
  final dynamic photoUrl;
  final dynamic name;
  final dynamic bloodGrp;
  final dynamic city;
  final dynamic mobile;
  const UserDetailScreen(
      {Key? key,
      required dynamic this.photoUrl,
      required dynamic this.name,
      required dynamic this.bloodGrp,
      required dynamic this.city,
      required dynamic this.mobile})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        centerTitle: true,
        title: Text('User Details'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Image.network(
                  //https://images.unsplash.com/photo-1657664057995-df654eb2bc57?ixlib=rb-1.2.1&ixid=MnwxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1032&q=80
                  photoUrl,
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: 150,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Divider(),
              Container(
                padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Username',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      name,
                      style: TextStyle(fontSize: 16, height: 1),
                    ),
                    const SizedBox(height: 15),
                    Divider(),
                    Text(
                      'Blood group',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      bloodGrp,
                      style: TextStyle(fontSize: 16, height: 1),
                    ),
                    const SizedBox(height: 15),
                    Divider(),
                    Text(
                      'City',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      city,
                      style: TextStyle(fontSize: 16, height: 1),
                    ),
                    const SizedBox(height: 15),
                    Divider(),
                    Text(
                      'Contact',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      mobile,
                      style: TextStyle(fontSize: 16, height: 1),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
