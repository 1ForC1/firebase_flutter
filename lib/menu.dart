import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'finance_list.dart';
import 'profile.dart';


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

  int currentIndex = 0;

    final listPage = [
    const FinanceList(
      title: 'Список финансов',
    ),
    const Profile(
      title: 'Профиль',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xffffb300),
        unselectedItemColor: Colors.black45,
        selectedItemColor: Colors.black,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        currentIndex: currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.money),
            label: 'Список финансов',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Профиль',
          ),
        ],
      ),
      body: listPage[currentIndex]
    );
  }
}
