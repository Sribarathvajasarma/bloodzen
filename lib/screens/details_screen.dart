import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailsScreen extends StatelessWidget {
  final snap;
  const DetailsScreen({Key? key, required this.snap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        centerTitle: true,
        title: Text('Details'),
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
                  snap['profImage'],
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
                      snap['username'],
                      style: TextStyle(fontSize: 16, height: 1),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Divider(),
                    Text(
                      'Description',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      snap['description'],
                      style: TextStyle(fontSize: 16, height: 1),
                    ),
                    const SizedBox(height: 15),
                    Divider(),
                    Text(
                      'Required blood group',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      snap["bloodGrp"],
                      style: TextStyle(fontSize: 16, height: 1),
                    ),
                    const SizedBox(height: 15),
                    Divider(),
                    Text(
                      'Posted at',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      DateFormat.yMMMd().format(
                        snap['datePublished'].toDate(),
                      ),
                      style: TextStyle(fontSize: 16, height: 1),
                    ),
                    const SizedBox(height: 15),
                    Divider(),
                    Text(
                      'Needed before',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      snap['neededBefore'],
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
                      "0769838892",
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
