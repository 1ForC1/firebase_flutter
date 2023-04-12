import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ImageWidget extends StatelessWidget {
  final String? name;
  final int? size;
  final String? url;
  final BuildContext? contextWidget;
  final db = FirebaseFirestore.instance;

  ImageWidget(
      {Key? key,
      required this.name,
      required this.size,
      required this.url,
      required this.contextWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          height: 350,
          width: 250,
          child: Container(
            decoration: const BoxDecoration(
                color: Color.fromARGB(188, 253, 90, 31),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  name!,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Image.network(url!, fit: BoxFit.fill,),
                 const SizedBox(
                  height: 10,
                ),
                Text(
                  size.toString(),
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.normal),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        db.collection("images").doc(name).delete();
                      },
                      child: const Text('Удалить'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
