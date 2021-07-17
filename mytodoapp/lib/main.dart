import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyAuthPage(),
    )
  }
}

class MyAuthPage extends StatefulWidget {
  @override
  _MyAuthPageState createState() => _MyAuthPageState();
}

class _MyAuthPageState extends State<MyAuthPage> {
  String newUserEmail = "";
  String newUserPassword = "";
  String infoText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Container(
              padding: EdgeInsets.all(32),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(labelText: "メールアドレス"),
                    onChanged: (String value) {
                      setState(() {
                        newUserEmail = value;
                      });
                    },
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    decoration: InputDecoration(labelText: "パスワード（6文字以上）"),
                    // 見えないようにする
                    obscureText: true,
                    onChanged: (String value) {
                      setState(() {
                        newUserPassword = value;
                      });
                    },
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        final FirebaseAuth auth = FirebaseAuth.instance;
                        final UserCredential result =
                        await auth.createUserWithEmailAndPassword(
                            email: newUserEmail, password: newUserPassword
                        );

                        final User user = result.user!;
                        setState(() {
                          infoText = "登録OK: ${user.email}";
                        });
                      } catch (e) {
                        setState(() {
                          infoText = "登録NG:${e.toString()}"
                        });
                      }
                    },
                    child: Text("ユーザー登録"),
                  ),
                  const SizedBox(height: 8),
                  Text(infoText)
                ],
              )
          ),
        )
    );
  }
}
