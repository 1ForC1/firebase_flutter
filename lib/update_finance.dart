import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

TextEditingController _name_controller = TextEditingController();
TextEditingController _description_controller = TextEditingController();
final db = FirebaseFirestore.instance;
final auth = FirebaseAuth.instance;

class UpdateFinance extends StatefulWidget {
  const UpdateFinance({super.key, required this.title});
  final String title;

  @override
  State<UpdateFinance> createState() => UpdateFinanceState();
}

class UpdateFinanceState extends State<UpdateFinance> {
  String? name = "";
  String? description = "";

  @override
  void initState() {
    _name_controller.addListener(onChange);
    _description_controller.addListener(onChange);
    super.initState();
  }

  void onChange() {
    name = _name_controller.text;
    description = _description_controller.text;
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
        title: const Text("Изменение финанса"),
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
                  controller: _name_controller,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Поле название пустое';
                    }
                    return null;
                  },
                  maxLength: 32,
                  decoration: const InputDecoration(
                    labelText: 'Название',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 200,
                height: 100,
                child: TextFormField(
                  maxLines: null,
                  controller: _description_controller,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Поле описание пустое';
                    }
                    return null;
                  },
                  maxLength: 100,
                  decoration: const InputDecoration(
                    labelText: 'Описание',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  SharedPreferences shared =
                      await SharedPreferences.getInstance();
                  String oldName = shared.getString('name') ?? "";
                  db.collection("finances").doc(oldName).delete().then(
                    (value) async {
                      final finance = <String, dynamic>{
                        "name": name,
                        "description": description,
                        "user": auth.currentUser!.email
                      };

                      db.collection("finances").doc(name).set(finance);

                      Navigator.pushNamed(
                        context,
                        'menu',
                      );
                    },
                  );
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
