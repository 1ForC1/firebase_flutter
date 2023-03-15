import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  String email = '';
  String uid = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;

  @override
  void initState() {
    user = _auth.currentUser;
    if (user != null) {
      if (user!.email != null) {
        email = user!.email!;
      } else {
        email = "Анонимус:):):):)";
      }
      uid = user!.uid;
    } else
      super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text("Выход"),
              onPressed: () async {
                await _auth.signOut();
                Navigator.pushNamed(
                  context,
                  'auth',
                );
              },
            ),
            Text("email: ${email}, id: ${uid}")
          ],
        ),
      ),
    );
  }
}
