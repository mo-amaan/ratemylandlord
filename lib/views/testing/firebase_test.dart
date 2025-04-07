import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FirebaseTest extends StatelessWidget {
  FirebaseTest({Key? key}) : super(key: key);

  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: FutureBuilder(
          future: _fbApp,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              if (kDebugMode) {
                print("You have an error! ${snapshot.error.toString()}");
              }
              return const Text("Something Went wrong!");
            } else if (snapshot.hasData) {
              return const MyHomePage(title: "Firebase Connected Successfully");
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        )
      //const MyHomePage(),

    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  Widget _buildListItem(BuildContext context, QueryDocumentSnapshot document) {
    return Card(
        color: Colors.white,
        //shadowColor: Colors.black.withAlpha(70),
        child: ListTile(
          title: Text(document['name']),
          //onTap: callBack,
          onTap: () {},
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('students').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Text('Loading...');
            } else {
              print(snapshot.data!.docs.last.id);
              return ListView.builder(
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (context, index) =>
                    _buildListItem(context, snapshot.data!.docs[index]),
              );
            }
          }
      ),
    );
  }
}