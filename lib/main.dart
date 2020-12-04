import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GoogleSignIn googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('G-Login'), actions: <Widget>[
          FutureBuilder(
            future: googleSignIn
                .isSignedIn(), // Checks whether user is already logged in or not
            builder: (_, AsyncSnapshot<bool> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.data) {
                  // already logged in
                  return IconButton(
                      icon: Icon(Icons.block),
                      onPressed: () async {
                        try {
                          await googleSignIn.signOut();
                          setState(() {});
                        } catch (error) {}
                      });
                } else {
                  // no user logged in
                  return IconButton(
                      icon: Icon(Icons.account_circle),
                      onPressed: () async {
                        await googleSignIn.signIn();
                        setState(() {});
                      });
                }
              } else {
                return CircularProgressIndicator();
              }
            },
          )
        ]),
        body: Center(
          child: Column(
            children: <Widget>[
              Text('hi ${googleSignIn.currentUser?.displayName}!!'),
              FutureBuilder(
                future: googleSignIn.currentUser?.authentication,
                builder:
                    (_, AsyncSnapshot<GoogleSignInAuthentication> snapShot) {
                  return snapShot.connectionState == ConnectionState.done
                      ? (snapShot.hasData
                          ? Text('id-token, ${snapShot.data.idToken}')
                          : Text('Ooops something went wrong'))
                      : Text('loading....');
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
