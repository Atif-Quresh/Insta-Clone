import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/resources/auth_method.dart';

import 'login_screen.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String userName = '';
  String userEmail = '';

  Future<void> fetchProfileDetails() async {
    final userDetails = await FirebaseFirestore.instance
        .collection('Users')
        .doc(_auth.currentUser!.uid)
        .get();

    setState(() {
      userName = userDetails['username'];
      print(userName);
      userEmail = userDetails["email"];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchProfileDetails();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("Clone Devs"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: InkWell(
              child: Icon(Icons.power_settings_new),
              onTap: () async {
                await AuthMethods().signOut();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                );
              },
            ),
          )
        ],
      ),
      body: Center(child: Text("Welcome ${userName} to Clone Devs")),
    );
  }
}
// asnn@gshd.com
