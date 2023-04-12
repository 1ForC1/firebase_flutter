import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'finance_widget.dart';
import 'image_widget.dart';

final auth = FirebaseAuth.instance;
final db = FirebaseFirestore.instance;

class FinanceList extends StatefulWidget {
  const FinanceList({super.key, required this.title});
  final String title;

  @override
  State<FinanceList> createState() => FinanceListState();
}

class FinanceListState extends State<FinanceList> {
  var listFinance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.black,
          onPressed: () async {
            await auth.signOut();
            Navigator.pushNamed(
              context,
              'auth',
            );
          },
        ),
        title: const Text("Финансы и картинки"),
        centerTitle: true,
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'create_finance');
                },
                child: Text("Добавить финансы"),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () async {
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles();

                  if (result != null) {
                    Uint8List? fileBytes = result.files.first.bytes;
                    String fileName = result.files.first.name;

                    var size = result.files.first.size;

                    final ref = await FirebaseStorage.instance
                        .ref('images/$fileName')
                        .putData(fileBytes!);

                    if (ref.state == TaskState.success) {
                      final String downloadUrl = await ref.ref.getDownloadURL();
                      await FirebaseFirestore.instance.collection("images").add(
                          {"url": downloadUrl, "name": fileName, "size": size});
                    } else {
                      print('Error from image repo ${ref.state.toString()}');
                      throw ('This file is not an image');
                    }
                  }
                },
                child: Text("Добавить картинку"),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 700,
                width: 400,
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('finances')
                      .where("user", isEqualTo: auth.currentUser!.email)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return const Text('Something went wrong');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Text("Загрузка");
                    }

                    final data = snapshot.requireData;

                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: data.size,
                      itemBuilder: (context, index) {
                        return FinanceWidget(
                          name: data.docs[index]['name'],
                          description: data.docs[index]['description'],
                          contextWidget: context,
                        );
                      },
                    );
                  },
                ),
              ),
              SizedBox(
                height: 700,
                width: 400,
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('images')
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return const Text('Something went wrong');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Text("Загрузка");
                    }

                    final data = snapshot.requireData;

                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: data.size,
                      itemBuilder: (context, index) {
                        return ImageWidget(
                          name: data.docs[index]['name'],
                          size: data.docs[index]['size'],
                          url: data.docs[index]['url'],
                          contextWidget: context,
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
