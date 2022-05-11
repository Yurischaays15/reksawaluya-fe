import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reksawaluya/models/PasienModel.dart';
import 'package:reksawaluya/network/network.dart';
import 'package:reksawaluya/routes/Poliklinik/index.dart';
import 'package:reksawaluya/utils/AllStyles.dart';
import 'package:reksawaluya/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PendaftaranAdminView extends StatefulWidget {
  const PendaftaranAdminView({Key? key}) : super(key: key);

  @override
  _PendaftaranAdminViewState createState() => _PendaftaranAdminViewState();
}

class _PendaftaranAdminViewState extends State<PendaftaranAdminView> {
  final Network network = Get.find();
  List<Widget> childs = [];

  _fetchPasiens() async {
    childs.clear();
    List<PasienModel> pasiens = [];
    final result = await network.doGet('/pasien/list');
    Iterable d = jsonDecode(result.body);
    pasiens = List<PasienModel>.from(
        d.map((model) => PasienModel.fromJson(model)));
    for (var element in pasiens) {
      var h = Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.black45)),
            child: InkWell(
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setString(Constant.medRecordKey, element.medicalRecord!);
                await prefs.setString(Constant.tanggalKey, element.date!);
                await prefs.setString(Constant.nameKey, element.name!);
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PoliklinikView()),
                );
                _fetchPasiens();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(element.name!, style: AllStyles.primaryBody,),
                  ],
                ),
              ),
            ),
          ));
      childs.add(h);
    }
    setState(() {

    });
  }



  @override
  void initState() {
    super.initState();
    _fetchPasiens();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 10,),
          ...childs
        ],
      ),
    );
  }
}
