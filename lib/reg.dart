import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Reg extends StatefulWidget {
  Reg({Key? key}) : super(key: key);

  @override
  State<Reg> createState() => _RegState();
}

class _RegState extends State<Reg> {
  String password = '';
  String email = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 300,
            height: 70,
            child: TextFormField(
              onChanged: (value) {
                email = value;
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Поле логин пустое';
                }
                return null;
              },
              maxLength: 50,
              decoration: const InputDecoration(
                labelText: 'Логин',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: 300,
            height: 70,
            child: TextFormField(
              onChanged: (value) {
                password = value;
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Поле пароль пустое';
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
          ElevatedButton(
            child: const Text("Регистрация"),
            onPressed: () async {
              final auth = FirebaseAuth.instance;
              try {
                UserCredential userCredential =
                    await auth.createUserWithEmailAndPassword(
                        email: email, password: password);
                Navigator.pushNamed(
                  context,
                  'auth',
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
            },
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(
                context,
                'auth',
              );
            },
            child: const Text('Уже есть аккаунт?',
                style: TextStyle(decoration: TextDecoration.underline)),
          ),
        ],
      )),
    );
  }
}
