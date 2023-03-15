import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_firebase/menu.dart';
import 'package:flutter_firebase/reg.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        'auth': (context) => const MyHomePage(
              title: 'Авторизация',
            ),
        'reg': (context) => Reg(),
        'menu': (context) => Menu(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Firebase'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                child: const Text("Авторизация"),
                onPressed: () async {
                  final auth = FirebaseAuth.instance;
                  try {
                    UserCredential userCredential =
                        await auth.signInWithEmailAndPassword(
                            email: email, password: password);

                    Navigator.pushNamed(
                      context,
                      'menu',
                    );
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'user-not-found') {
                      print('Пользователь не найден.');
                    } else if (e.code == 'wrong-password') {
                      print('Пароль не верный.');
                    }
                  } catch (e) {
                    print(e);
                  }
                },
              ),
              const SizedBox(
                width: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  final auth = FirebaseAuth.instance;
                  try {
                    UserCredential userCredential =
                        await auth.signInAnonymously();

                    Navigator.pushNamed(
                      context,
                      'menu',
                    );
                  } catch (e) {
                    print(e);
                  }
                },
                child: const Text(
                  'Войти как анонимус:):):)',
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () async {
              final FirebaseAuth user = FirebaseAuth.instance;
              try {
                user.sendSignInLinkToEmail(
                  email: email,
                  actionCodeSettings: ActionCodeSettings(
                      url: "https://superduperauth.page.link/rniX",
                      androidMinimumVersion: "16",
                      androidPackageName: "com.example.app",
                      iOSBundleId: "com.example.app",
                      androidInstallApp: true,
                      handleCodeInApp: true),
                );

                Navigator.pushNamed(
                  context,
                  'menu',
                );
              } catch (e) {
                print(e.toString());
              }
            },
            child: const Text('Забыли пароль? Войти через почту',
                style: TextStyle(decoration: TextDecoration.underline)),
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(
                context,
                'reg',
              );
            },
            child: const Text('Создать аккаунт',
                style: TextStyle(decoration: TextDecoration.underline)),
          ),
        ],
      )),
    );
  }
}
