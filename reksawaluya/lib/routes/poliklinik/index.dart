import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';
import 'package:reksawaluya/models/PoliklinikModel.dart';
import 'package:reksawaluya/network/network.dart';
import 'package:reksawaluya/routes/home/components/MenuBox/index.dart';
import 'package:reksawaluya/routes/poliklinik/add_poli/AddPoli.dart';
import 'package:reksawaluya/routes/poliklinik/detail_poli/index.dart';
import 'package:reksawaluya/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'menucomp.dart';

class PoliklinikView extends StatefulWidget {
  const PoliklinikView({Key? key}) : super(key: key);

  @override
  _PoliklinikViewState createState() => _PoliklinikViewState();
}

class _PoliklinikViewState extends State<PoliklinikView> {
  final Network network = Get.find();
  List<PoliklinikModel> polis = [];
  bool isAdminOrPoli = false;
  List<Widget> _poliMenus = [];

  _fetchPolis() async {
    polis.clear();
    _poliMenus.clear();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isAdminOrPoli = prefs.getInt(Constant.roleKey) == Constant.roleAdmin ||
        prefs.getInt(Constant.roleKey) == Constant.rolePoli;
    final result = await network.doGet('/poliklinik/list/');
    Iterable d = jsonDecode(result.body);
    polis = List<PoliklinikModel>.from(
        d.map((model) => PoliklinikModel.fromJson(model)));
    String name = prefs.getString(Constant.secondNameKey)!;
    int? role = prefs.getInt(Constant.roleKey);
    if (role == Constant.rolePoli) {
      polis = polis
          .where((element) => element.poliklinikName!
              .toLowerCase()
              .contains(name.toLowerCase()))
          .toList();
    }
    for (int i = 0; i < polis.length; i = i + 2) {
      if (polis.asMap().containsKey(i + 1)) {
        Widget holder = Padding(
            padding: const EdgeInsets.all(8),
            child: Card(
              child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MenuComp(
                    destination: DetailPoliklinik(poliklinik: polis[i]),
                    text: polis[i].poliklinikName!,
                    img64: polis[i].poliklinikIcon!),
                const SizedBox(
                  width: 20,
                ),
                MenuComp(
                    destination: DetailPoliklinik(poliklinik: polis[i + 1]),
                    text: polis[i + 1].poliklinikName!,
                    img64: polis[i + 1].poliklinikIcon!)
              ],
            )));
        _poliMenus.add(holder);
      } else {
        Widget holder = Padding(
            padding: const EdgeInsets.all(8),
            child: Card(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MenuComp(
                    destination: DetailPoliklinik(poliklinik: polis[i]),
                    text: polis[i].poliklinikName!,
                    img64: polis[i].poliklinikIcon!),
              ],
            )));
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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Daftar Poliklinik'),
      ),
      floatingActionButton: isAdminOrPoli
          ? FloatingActionButton(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddPoliView()),
                );
                _fetchPolis();
              },
              backgroundColor: Colors.green,
              child: const Icon(Icons.add_outlined),
            )
          : null,
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ..._poliMenus,
          ],
        ),
      ),
    ),
    );
  }
}
