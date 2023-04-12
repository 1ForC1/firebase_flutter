import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/finance_list.dart';

TextEditingController _operationNumber_controller = TextEditingController();
TextEditingController _name_controller = TextEditingController();
TextEditingController _description_controller = TextEditingController();
TextEditingController _category_controller = TextEditingController();
TextEditingController _sum_controller = TextEditingController();
final db = FirebaseFirestore.instance;

class CreateFinance extends StatefulWidget {
  const CreateFinance({super.key, required this.title});
  final String title;

  @override
  State<CreateFinance> createState() => CreateFinanceState();
}

class CreateFinanceState extends State<CreateFinance> {
  String? operationNumber = "";
  String? name = "";
  String? description = "";
  String? category = "";
  DateTime selectedDate = DateTime.now();
  String? sum = "";

  @override
  void initState() {
    _operationNumber_controller.addListener(onChange);
    _name_controller.addListener(onChange);
    _description_controller.addListener(onChange);
    _category_controller.addListener(onChange);
    _sum_controller.addListener(onChange);
    super.initState();
  }

  void onChange() {
    operationNumber = _operationNumber_controller.text;
    name = _name_controller.text;
    description = _description_controller.text;
    category = _category_controller.text;
    sum = _sum_controller.text;
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
        title: const Text("Добавление финанса"),
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
                height: 10,
              ),
              ElevatedButton(
                onPressed: () async {
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
                child: const Text('Добавить'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
