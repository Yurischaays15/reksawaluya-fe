import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:reksawaluya/utils/AllStyles.dart';

class MenuBox extends StatelessWidget {
  final String text;
  final LineIcon icon;
  final Widget? destination;
  const MenuBox({Key? key, required this.text, required this.icon, this.destination})
      : super(key: key);

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
              MaterialPageRoute(builder: (context) => destination!),
            );
          },
          child: Column(
            children: [
              icon,
              Text(
                text,
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
