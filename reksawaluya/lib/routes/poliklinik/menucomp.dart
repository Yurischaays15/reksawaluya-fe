import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:reksawaluya/utils/AllStyles.dart';

class MenuComp extends StatefulWidget {
  final String text;
  final String img64;
  final Widget? destination;
  const MenuComp({Key? key, required this.text, required this.img64, this.destination}) : super(key: key);

  @override
  _MenuCompState createState() => _MenuCompState();
}

class _MenuCompState extends State<MenuComp> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 135,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.black45)),
        child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => widget.destination!),
            );
          },
          child: Column(
            children: [
              Image.memory(
                base64Decode(widget.img64),
                height: 120,
                width: 120,
              ),
              Text(
                widget.text,
                style: AllStyles.primaryMenu(),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
