import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

TextEditingController _password_controller = TextEditingController();
TextEditingController _email_controller = TextEditingController();
final auth = FirebaseAuth.instance;
final db = FirebaseFirestore.instance;
CollectionReference usersTable = FirebaseFirestore.instance.collection('users');

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key, required this.title});
  final String title;

  @override
  State<UpdateProfile> createState() => ProfileState();
}

class ProfileState extends State<UpdateProfile> {
  String? login = "";
  String? password = "";
  String? email = "";

  @override
  void initState() {
    _password_controller.addListener(onChange);
    _email_controller.addListener(onChange);
    super.initState();
  }

  void onChange() {
    password = _password_controller.text;
    email = _email_controller.text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            Navigator.pushNamed(
              context,
              'menu',
            );
          },
        ),
        title: const Text("Редактирование профиля"),
        centerTitle: true,
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 200,
                height: 50,
                child: TextFormField(
                  controller: _password_controller,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Поле пароль пустое';
                    }
                    if (value.length < 3) {
                      return 'Пароль должен быть не менее 6 символов';
                    }
                    return null;
                  },
                  maxLength: 16,
                  decoration: const InputDecoration(
                    labelText: 'Пароль',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 200,
                height: 50,
                child: TextFormField(
                  controller: _email_controller,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Поле почта пустое';
                    }
                    return null;
                  },
                  maxLength: 32,
                  decoration: const InputDecoration(
                    labelText: 'Почта',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  usersTable
                      .doc(auth.currentUser!.email)
                      .delete()
                      .then((value) async {
                    User? currentUser = auth.currentUser!;
                    auth.currentUser!.delete();

                    try {
                      final user = <String, dynamic>{
                        "email": email,
                        "password": password
                      };

                      CollectionReference usersTable =
                          FirebaseFirestore.instance.collection('users');

                      usersTable.doc(email).set(user);

                      UserCredential userCredential =
                          await auth.createUserWithEmailAndPassword(
                              email: email!, password: password!);

                      final batch = FirebaseFirestore.instance.batch();

                      var finances = await FirebaseFirestore.instance
                          .collection('finances')
                          .where('user', isEqualTo: currentUser.email)
                          .get();
                      finances.docs.forEach((element) => {
                            batch.update(element.reference, {"user": email!})
                          });

                      batch.commit();
                      Navigator.pushNamed(
                        context,
                        'menu',
                      );
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        print('Пароль слишком слабый.');
                      } else if (e.code == 'email-already-in-use') {
                        print('Этот адрес эдектронной почты уже используется.');
                      }
                    } catch (e) {
                      print(e);
                    }
                  }).catchError((error) => print(error));
                },
                child: const Text('Изменить'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
