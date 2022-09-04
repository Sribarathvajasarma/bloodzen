import 'package:bloodzen/resources/auth_methods.dart';
import 'package:bloodzen/responsive/mobile_screen_layout.dart';
import 'package:bloodzen/responsive/responsive_layout_screen.dart';
import 'package:bloodzen/responsive/web_screen_layout.dart';
import 'package:bloodzen/screens/login_screen.dart';
import 'package:bloodzen/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../utils/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> names = <String>['barath', 'Raju', 'sarma'];
  final List<String> description = <String>[
    'A+ blood needed',
    'O- needed urgent before 12/03/2022',
    'Can someone donate A- blood?'
  ];
  final List<String> bloodgroup = <String>['A+', 'O-', 'A+'];

  @override
  Widget build(BuildContext context) {
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
              onPressed: () {},
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
              ListView.separated(
                shrinkWrap: true,
                padding: const EdgeInsets.all(8),
                itemCount: names.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: Container(
                      height: 120,
                      color: Color.fromARGB(255, 56, 55, 55),
                      child: Row(
                        children: [
                          Center(
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Expanded(
                                child: Image.asset("assets/bloodzen.jpg"),
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
                                        "${names[index]}  Require : ${bloodgroup[index]} blood",
                                      ),
                                      subtitle: Text(
                                        "${description[index]}",
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
                                          child: Text("Donate"),
                                          onPressed: () {},
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
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
              ),
            ],
          ),
        ));
  }
}
