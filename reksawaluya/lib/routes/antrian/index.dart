import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';
import 'package:reksawaluya/models/PoliklinikModel.dart';
import 'package:reksawaluya/network/network.dart';
import 'package:reksawaluya/routes/antrian/AntrianDirector.dart';
import 'package:reksawaluya/routes/antrian/AntrianPasien.dart';
import 'package:reksawaluya/routes/home/components/MenuBox/index.dart';
import 'package:reksawaluya/routes/poliklinik/menucomp.dart';
import 'package:reksawaluya/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AntrianView extends StatefulWidget {
  const AntrianView({Key? key}) : super(key: key);

  @override
  _AntrianViewState createState() => _AntrianViewState();
}

class _AntrianViewState extends State<AntrianView> {
  final Network network = Get.find();
  List<PoliklinikModel> polis = [];

  List<Widget> _poliMenus = [];

  _fetchPolis() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? role = prefs.getInt(Constant.roleKey);
    final result = await network.doGet('/poliklinik/list/');
    Iterable d = jsonDecode(result.body);
    polis = List<PoliklinikModel>.from(
        d.map((model) => PoliklinikModel.fromJson(model)));
    if (role == Constant.rolePoli) {
      String name = prefs.getString(Constant.secondNameKey)!;
      polis = polis
          .where((element) =>
          element.poliklinikName!.toLowerCase().contains(name.toLowerCase()))
          .toList();
    }
    for (int i = 0; i < polis.length; i = i + 2) {
      if (polis.asMap().containsKey(i + 1)) {
        Widget holder = Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MenuComp(
                    destination: AntrianDirectorView(
                      kodepoli: polis[i].poliklinikKode!,
                      poliName: polis[i].poliklinikName!,
                    ),
                    text: polis[i].poliklinikName!,
                    img64: polis[i].poliklinikIcon!),
                const SizedBox(
                  width: 20,
                ),
                MenuComp(
                    destination: AntrianDirectorView(
                      kodepoli: polis[i+1].poliklinikKode!,
                      poliName: polis[i+1].poliklinikName!,
                    ),
                    text: polis[i + 1].poliklinikName!,
                    img64: polis[i+1].poliklinikIcon!)
              ],
            ));
        _poliMenus.add(holder);
      } else {
        Widget holder = Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MenuComp(
                    destination: AntrianDirectorView(
                      kodepoli: polis[i].poliklinikKode!,
                      poliName: polis[i].poliklinikName!,
                    ),
                    text: polis[i].poliklinikName!,
                    img64: polis[i].poliklinikIcon!),
              ],
            ));
        _poliMenus.add(holder);
      }
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchPolis();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Poliklinik'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ..._poliMenus,
          ],
        ),
      ),
    );
  }
}
