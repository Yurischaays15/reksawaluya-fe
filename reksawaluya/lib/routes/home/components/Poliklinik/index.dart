import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:reksawaluya/routes/home/components/MenuBox/index.dart';
import 'package:reksawaluya/routes/antrian/index.dart';
import 'package:reksawaluya/routes/poliklinik/index.dart' as p2;

class PoliklinikView extends StatelessWidget {
  const PoliklinikView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MenuBox(
                destination: const p2.PoliklinikView(),
                  text: 'Informasi\nPoliklinik',
                  icon: LineIcon.hospital(
                    size: 60,
                  )),
              const SizedBox(
                width: 20,
              ),
              MenuBox(
                destination: const AntrianView(),
                  text: 'Update\nAntrian',
                  icon: LineIcon.clock(
                    size: 60,
                  ))
            ],
          ),
        ],
      ),
    );
  }
}